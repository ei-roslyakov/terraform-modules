resource "aws_rds_cluster" "this" {
  count                               = var.create_cluster == true ? 1 : 0
  cluster_identifier                  = var.cluster_identifier
  master_username                     = var.user
  master_password                     = var.password
  backup_retention_period             = var.retention_period
  preferred_backup_window             = var.backup_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  final_snapshot_identifier           = lower(var.cluster_identifier)
  skip_final_snapshot                 = var.skip_final_snapshot
  apply_immediately                   = var.apply_immediately
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                          = var.kms_key_arn
  source_region                       = var.source_region
  snapshot_identifier                 = var.snapshot_identifier
  vpc_security_group_ids              = compact(flatten([join("", aws_security_group.default.*.id), var.vpc_security_group_ids]))
  preferred_maintenance_window        = var.maintenance_window
  db_subnet_group_name                = join("", aws_db_subnet_group.default.*.name)
  db_cluster_parameter_group_name     = join("", aws_rds_cluster_parameter_group.default.*.name)
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  engine                              = var.engine
  engine_version                      = var.engine_version
  engine_mode                         = var.engine_mode
  iam_roles                           = var.iam_roles
  backtrack_window                    = var.backtrack_window
  enable_http_endpoint                = var.engine_mode == "serverless" && var.enable_http_endpoint ? true : false

  tags = merge(
    {
      "Name" = format("%s", var.cluster_identifier)
    },
    var.tags,
  )

  depends_on = [
    aws_db_subnet_group.default,
    aws_db_parameter_group.default,
    aws_rds_cluster_parameter_group.default,
    aws_security_group.default,
  ]

  dynamic "scaling_configuration" {
    for_each = var.scaling_configuration
    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause", null)
      max_capacity             = lookup(scaling_configuration.value, "max_capacity", null)
      min_capacity             = lookup(scaling_configuration.value, "min_capacity", null)
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
      timeout_action           = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts_configuration
    content {
      create = lookup(timeouts.value, "create", "120m")
      update = lookup(timeouts.value, "update", "120m")
      delete = lookup(timeouts.value, "delete", "120m")
    }
  }

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  deletion_protection             = var.deletion_protection

  # replication_source_identifier = var.replication_source_identifier
  global_cluster_identifier = var.global_cluster_identifier

  lifecycle {
    ignore_changes = [
      replication_source_identifier,
      snapshot_identifier,
      global_cluster_identifier,
    ]
  }
}

resource "aws_rds_cluster_instance" "default" {
  count                           = var.create_cluster ? var.cluster_size : 0
  identifier                      = "${var.cluster_identifier}-${count.index + 1}"
  cluster_identifier              = join("", aws_rds_cluster.this.*.id)
  instance_class                  = var.instance_type
  db_subnet_group_name            = join("", aws_db_subnet_group.default.*.name)
  db_parameter_group_name         = join("", aws_db_parameter_group.default.*.name)
  publicly_accessible             = var.publicly_accessible
  engine                          = var.engine
  engine_version                  = var.engine_version
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  monitoring_interval             = var.rds_monitoring_interval
  monitoring_role_arn             = var.enhanced_monitoring_role_enabled ? join("", aws_iam_role.enhanced_monitoring.*.arn) : var.rds_monitoring_role_arn
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  availability_zone               = var.instance_availability_zone

  tags = merge(
    {
      "Name" = format("%s", var.cluster_identifier)
    },
    var.tags,
  )

  depends_on = [
    aws_db_subnet_group.default,
    aws_db_parameter_group.default,
    aws_iam_role.enhanced_monitoring,
    aws_rds_cluster.this,
    aws_rds_cluster_parameter_group.default,
  ]
}

resource "aws_db_subnet_group" "default" {
  count       = var.create_cluster ? 1 : 0
  name        = "${var.cluster_identifier}-subnet-group"
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = var.subnets
  tags = merge(
    {
      "Name" = format("%s", var.cluster_identifier)
    },
    var.tags,
  )
}

resource "aws_rds_cluster_parameter_group" "default" {
  count       = var.create_cluster ? 1 : 0
  name_prefix = "${var.cluster_identifier}-subnet-parameter-group"
  description = "DB cluster parameter group"
  family      = var.cluster_family

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = merge(
    {
      "Name" = format("%s", var.cluster_identifier)
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "default" {
  count       = var.create_cluster ? 1 : 0
  name_prefix = "${var.cluster_identifier}-cluster-parameter-group"
  description = "DB instance parameter group"
  family      = var.cluster_family

  dynamic "parameter" {
    for_each = var.instance_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = merge(
    {
      "Name" = format("%s", var.cluster_identifier)
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}


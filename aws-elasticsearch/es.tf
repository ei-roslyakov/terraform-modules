data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_service_linked_role" "es" {
  count            = var.create_iam_service_linked_role ? 1 : 0
  aws_service_name = "es.amazonaws.com"
}

#Take only X number of subnets where X is the number of available AZs)
locals {
  subnet_ids = slice(var.subnet_ids, 0, var.instance_count)
}

resource "aws_elasticsearch_domain" "es" {
  count = var.create_elasticsearch ? 1 : 0

  domain_name           = var.es_domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_type    = var.dedicated_master_type
    zone_awareness_enabled   = var.zone_awareness_enabled
    dynamic "zone_awareness_config" {
      for_each = var.instance_count > 1 ? [var.instance_count] : []
      content {
        availability_zone_count = var.instance_count
      }
    }
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  vpc_options {
    subnet_ids = local.subnet_ids
    # subnet_ids         = var.subnet_ids
    security_group_ids = [join("", aws_security_group.es_security_group.*.id)]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.es_domain_name}/*"
        }
    ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  tags = merge(
    {
      "Name" = format("%s", var.es_domain_name)
    },
    var.tags,
  )
}

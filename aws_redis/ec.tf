locals {
  redis_subnet_group_tag_name = format("%s-%s", var.elasticache_clustes_name, "subnet")
  replication_group_id        = format("%s", var.elasticache_clustes_name)
  elasticache_member_clusters = var.create_elasticache ? tolist(aws_elasticache_replication_group.redis_replication_group.0.member_clusters) : []
}

data "aws_region" "current" {}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  count = var.create_elasticache ? 1 : 0

  name       = local.redis_subnet_group_tag_name
  subnet_ids = var.subnets
}

resource "aws_elasticache_replication_group" "redis_replication_group" {
  count = var.create_elasticache ? 1 : 0

  automatic_failover_enabled    = var.automatic_failover_enabled
  availability_zones            = var.azs
  replication_group_id          = local.replication_group_id
  replication_group_description = local.replication_group_id
  node_type                     = var.node_type
  number_cache_clusters         = var.num_cache_nodes
  engine                        = var.engine
  engine_version                = var.engine_version
  port                          = var.elasticache_redis_port
  subnet_group_name             = join("", aws_elasticache_subnet_group.redis_subnet_group.*.name)
  security_group_ids            = [join("", aws_security_group.redis-sg.*.id)]
  multi_az_enabled              = var.multi_az_enabled

  tags = merge(
    {
      "Name" = format("%s", var.elasticache_clustes_name)
    },
    var.tags,
  )
  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
}
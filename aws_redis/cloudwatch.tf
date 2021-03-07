resource "aws_cloudwatch_metric_alarm" "cache_memory" {
  count = var.create_elasticache ? var.num_cache_nodes : 0

  alarm_name          = "${element(local.elasticache_member_clusters, count.index)}-high-ram-utilization"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Minimum"
  comparison_operator = "LessThanThreshold"
  threshold           = "512"
  alarm_description   = "Redis cluster freeable memory"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    CacheClusterId = element(local.elasticache_member_clusters, count.index)
  }

  tags = merge(
    {
      "Name" = format("%s", var.elasticache_clustes_name)
    },
    var.tags,
  )
}

resource "aws_cloudwatch_metric_alarm" "cache-cpuutil" {
  count               = var.create_elasticache ? var.num_cache_nodes : 0
  alarm_name          = "${element(local.elasticache_member_clusters, count.index)}-high-cpu-utilization"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "50"
  alarm_description   = "This metric controls elasticcache high cpu utilization"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    CacheClusterId = element(local.elasticache_member_clusters, count.index)
  }

  tags = merge(
    {
      "Name" = format("%s", var.elasticache_clustes_name)
    },
    var.tags,
  )
}

resource "aws_cloudwatch_metric_alarm" "cache-swap" {
  count               = var.create_elasticache ? var.num_cache_nodes : 0
  alarm_name          = "${element(local.elasticache_member_clusters, count.index)}-swapusage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "SwapUsage"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"
  threshold           = "50000000"
  alarm_description   = "This metric controls elastic-cache swap usage"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    CacheClusterId = element(local.elasticache_member_clusters, count.index)
  }
  tags = merge(
    {
      "Name" = format("%s", var.elasticache_clustes_name)
    },
    var.tags,
  )
}

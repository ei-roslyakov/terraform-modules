resource "aws_route53_health_check" "check" {
  fqdn              = var.fqdn
  port              = var.port
  type              = var.type
  resource_path     = var.resource_path
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "${var.name}_alarm_healthcheck_failed"
  namespace           = "AWS/Route53"
  metric_name         = "HealthCheckStatus"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "1"

  dimensions = {
    "HealthCheckId" = aws_route53_health_check.check.id
  }

  alarm_description         = "This metric monitors of ${var.name} endpoint"
  ok_actions                = [var.ok_actions]
  alarm_actions             = [var.alarm_actions]
  insufficient_data_actions = [var.insufficient_data_actions]
  treat_missing_data        = "breaching"
}

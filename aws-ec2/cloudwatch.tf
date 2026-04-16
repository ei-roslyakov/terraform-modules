resource "aws_cloudwatch_metric_alarm" "ec2_cpu_util" {
  count = var.cpu_threshold > 0 ? 1 : 0

  alarm_name          = "ec2-${var.name}-cpu-util"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "900"
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "CPUUtilization in ${var.name} EC2"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data

  dimensions = {
    InstanceId = join("", aws_instance.default.*.id)
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_credit_util" {
  count = var.cpu_credit_threshold > 0 ? 1 : 0

  alarm_name          = "ec2-${var.name}-cpu-credit-util"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUCreditBalance"
  namespace           = "AWS/EC2"
  period              = "900"
  statistic           = "Average"
  threshold           = var.cpu_credit_threshold
  alarm_description   = "CPUCreditBalance in ${var.name} EC2"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data

  dimensions = {
    InstanceId = join("", aws_instance.default.*.id)
  }
}
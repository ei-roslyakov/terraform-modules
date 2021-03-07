resource "aws_cloudwatch_metric_alarm" "elk-JvmMemPressure" {
  count = var.enabling_cloudwatch_monitoring ? 1 : 0

  alarm_name          = "${var.es_domain_name}-es-JvmMemPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "JVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = "300"
  statistic           = "Average"
  threshold           = "80.0"
  alarm_description   = "JVMMemoryPressure in ${var.es_domain_name} ElasticSearch is >= 80%"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    DomainName = var.es_domain_name
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elk-cpuutil" {
  count = var.enabling_cloudwatch_monitoring ? 1 : 0

  alarm_name          = "${var.es_domain_name}-es-cpuutil"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ES"
  period              = "900"
  statistic           = "Average"
  threshold           = "80.0"
  alarm_description   = "CPUUtilization in ${var.es_domain_name} ElasticSearch"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    DomainName = var.es_domain_name
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elk-failsnapshot" {
  count = var.enabling_cloudwatch_monitoring ? 1 : 0

  alarm_name          = "${var.es_domain_name}-es-failsnapshot"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AutomatedSnapshotFailure"
  namespace           = "AWS/ES"
  period              = "300"
  statistic           = "Average"
  threshold           = "1.0"
  alarm_description   = "AutomatedSnapshotFailure in ${var.es_domain_name} ElasticSearch"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    DomainName = var.es_domain_name
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elk-nodecount" {
  count = var.enabling_cloudwatch_monitoring ? 1 : 0

  alarm_name          = "${var.es_domain_name}-es-nodecount"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Nodes"
  namespace           = "AWS/ES"
  period              = "300"
  statistic           = "Average"
  threshold           = "1.0"
  alarm_description   = "Nodes in domain less then one in ${var.es_domain_name} ElasticSearch"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    DomainName = var.es_domain_name
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elk-red" {
  count = var.enabling_cloudwatch_monitoring ? 1 : 0

  alarm_name          = "${var.es_domain_name}-es-red"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ClusterStatus.red"
  namespace           = "AWS/ES"
  period              = "300"
  statistic           = "Average"
  threshold           = "1.0"
  alarm_description   = "ClusterStatus Red in ${var.es_domain_name} ElasticSearch"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    DomainName = var.es_domain_name
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elk-yellow" {
  count = var.enabling_cloudwatch_monitoring ? 1 : 0

  alarm_name          = "${var.es_domain_name}-es-yellow"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AlertingIndexStatus.yellow"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Average"
  threshold           = "1.0"
  alarm_description   = "ClusterStatus yellow in ${var.es_domain_name} ElasticSearch"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    DomainName = var.es_domain_name
    ClientId   = data.aws_caller_identity.current.account_id
  }
}
resource "aws_cloudwatch_metric_alarm" "elk-storage-space" {
  count = var.enabling_cloudwatch_monitoring ? 1 : 0

  alarm_name          = "${var.es_domain_name}-es-storage-space"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/ES"
  period              = "300"
  statistic           = "Average"
  threshold           = "20480"
  alarm_description   = "FreeStorageSpace in ${var.es_domain_name} ElasticSearch"
  ok_actions          = [var.tg_unhealthy_ok_actions]
  alarm_actions       = [var.tg_unhealthy_alarm_actions]
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    DomainName = var.es_domain_name
    ClientId   = data.aws_caller_identity.current.account_id
  }
}
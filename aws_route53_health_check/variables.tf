variable "name" {
  default     = false
  description = "The name of the check"
}

variable "fqdn" {
  default     = false
  description = "The fully qualified domain name of the endpoint to be checked"
}

variable "port" {
  default     = false
  description = "The port of the endpoint to be checked"
}

variable "type" {
  description = "The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC"
  default = ""
}

variable "resource_path" {
  default     = false
  description = "The path that you want Amazon Route 53 to request when performing health checks."
}

variable "failure_threshold" {
  description = "The number of consecutive health checks that an endpoint must pass or fail"
  default = ""
}

variable "request_interval" {
  description = "The number of seconds between the time that Amazon Route 53 gets a response from your endpoint and the time that it sends the next health-check request."
  default = ""
}

variable "cloudwatch_alarm_region" {
  description = "The CloudWatchRegion that the CloudWatch alarm was created in."
  default = ""
}

variable "ok_actions" {
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  default = ""
}

variable "alarm_actions" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  default = ""
}

variable "insufficient_data_actions" {
  description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  default = ""
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
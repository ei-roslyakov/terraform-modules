variable "create_globalaccelerator_accelerator" {
  description = "Controls if Globalaccelerator resources should be created"
  type        = bool
  default     = true
}

variable "name" {
  type    = string
  default = ""
}

variable "flow_logs_enabled" {
  description = "Indicates whether flow logs are enabled. Defaults to false"
  type        = bool
  default     = false
}

variable "flow_logs_s3_bucket" {
  description = "The name of the Amazon S3 bucket for the flow logs. Required if flow_logs_enabled is true"
  type        = string
  default     = ""
}

variable "flow_logs_s3_prefix" {
  description = "The prefix for the location in the Amazon S3 bucket for the flow logs. Required if flow_logs_enabled is true"
  type        = string
  default     = ""
}

variable "create_route53_record" {
  type    = bool
  default = false
}

variable "route53_zone_id" {
  type        = string
  default     = ""
  description = "[Optional] route53 zone id"
}

variable "route53_record_name" {
  type        = string
  default     = ""
  description = "[Optional] DNS name of the global accelerator to be added to route53 zone"
}

variable "create_elb_listener" {
  type        = bool
  default     = true
  description = "Whether to add var.elb_endpoint to global accelerator endpoints"
}

variable "endpoint_group_region" {
  type        = string
  default     = ""
  description = "The name of the AWS Region where the endpoint group is located."
}

variable "endpoint_configuration" {
  description = "The list of endpoint objects."
  type        = any
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
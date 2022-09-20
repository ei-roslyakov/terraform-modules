variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "ingress_rules" {
  type        = any
  default     = []
  description = "Ingress rules that will be attached to the SG"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
}

variable "description" {
  type        = string
  default     = "Instance default security group (only egress access is allowed)."
  description = "The security group description."
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

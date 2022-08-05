variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "enable_security_group" {
  type        = bool
  default     = true
  description = "Enable default Security Group with only Egress traffic allowed."
}

variable "name_pefix" {
  type        = bool
  default     = true
  description = "Use prefix for SG name"
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

variable "allowed_ports_sg" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "allowed_ports_cidr" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed ip."
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "List of Security Group IDs allowed to connect to the instance."
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}


variable "prefix_list" {
  type        = list(any)
  default     = []
  description = "List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress"
}
variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "custom_ingress_rule_cidr" {
  description = "Some description here"
  type        = any
  default     = {}
}
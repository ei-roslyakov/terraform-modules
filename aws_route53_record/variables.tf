variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "name" {
  type        = string
  description = "The Name of the application or solution  (e.g. `bastion` or `portal`)"
  default     = ""
}
variable "private_zone" {
  type        = bool
  default     = true
  description = "Search filter for zone, if private set true"
}
variable "zone_name" {
  type        = string
  description = "The Hosted Zone name of the desired Hosted Zone"
}

variable "records" {
  type        = list(string)
  description = "DNS records to create"
  default     = ""
}

variable "type" {
  type        = string
  default     = "CNAME"
  description = "Type of DNS records to create"
}

variable "ttl" {
  type        = string
  default     = "300"
  description = "The TTL of the record to add to the DNS zone to complete certificate validation"
}

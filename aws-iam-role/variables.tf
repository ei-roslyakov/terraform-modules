variable "roles" {
  description = "A map of roles with parameters"
  type = map(object({
    name                    = optional(string)
    path                    = optional(string)
    description             = optional(string, "")
    instance_profile_enable = optional(bool, true)
    policy_arns             = optional(list(string))
    custom_tags             = optional(map(string))
    principals_type         = optional(string, "Service")
    principals_identifiers  = optional(list(string), ["ec2.amazonaws.com"])
  }))
  default = {}
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
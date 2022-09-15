variable "roles" {
  description = "A map of roles with parameters"
  type = map(object({
    name                    = optional(string)
    path                    = optional(string)
    instance_profile_enable = optional(bool)
    policy_arns             = optional(list(string))
    custom_tags             = optional(map(string))
  }))
  default = {}
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
variable "users" {
  description = "A map of users with parameters"
  type = map(object({
    name                    = optional(string)
    path                    = optional(string)
    permissions_boundary    = optional(string)
    force_destroy           = optional(bool)
    password_reset_required = optional(bool)
    password_length         = optional(string)
    custom_tags             = optional(map(string))
    policy                  = optional(list(string))
  }))
  default = {}
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
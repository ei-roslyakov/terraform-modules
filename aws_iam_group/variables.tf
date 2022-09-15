variable "groups" {
  description = "A map of users with parameters"
  type = map(object({
    name              = optional(string)
    path              = optional(string)
    group_users       = optional(list(string))
    group_policy_arns = optional(list(string))
  }))
  default = {}
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
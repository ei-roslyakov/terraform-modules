variable "policies" {
  description = "A map of policies with parameters"
  type = map(object({
    name        = optional(string)
    path        = optional(string)
    policy_path = optional(string)
    custom_tags = optional(map(string))
  }))
  default = {}
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
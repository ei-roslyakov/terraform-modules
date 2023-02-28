variable "identitystore_group" {
  description = "A map of users with parameters"
  type = map(object({
    display_name      = optional(string)
  description       = optional(string)
  }))
  default = {}
}
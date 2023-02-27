variable "identitystore_user" {
  description = "A map of users with parameters"
  type = map(object({
    display_name  = optional(string)
    user_name     = optional(string)
    given_name    = optional(string)
    family_name   = optional(string)
    email         = optional(string)
  }))
  default = {}
}
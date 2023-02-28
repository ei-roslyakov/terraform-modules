variable "identitystore_user" {
  description = "A list of users with parameters"
  type = list(object({
    user_name     = optional(string)
    given_name    = optional(string)
    family_name   = optional(string)
    email         = optional(string)
    groups        = optional(list(string))
    primary_email = optional(bool)
  }))
  default = []
}

variable "identitystore_group" {
  description = "A map of grops with parameters"
  type = map(object({
    display_name = optional(string)
    description  = optional(string)
  }))
  default = {}
}

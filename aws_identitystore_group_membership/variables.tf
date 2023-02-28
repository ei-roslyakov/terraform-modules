variable "identitystore_group_membership" {
  description = "A map of users with parameters"
  type = map(object({
    group_id     = optional(string)
    user_ids      = optional(list(string))
  }))
  default = {}
}
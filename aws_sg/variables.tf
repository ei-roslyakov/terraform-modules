variable "groups" {
  description = "A map of groups with parameters"
  type = map(object({
    name        = optional(string)
    description = optional(string)
    vpc_id      = optional(string)

    ingress_rules = optional(any)
    tags          = optional(map(string))
  }))
  default = {}
}
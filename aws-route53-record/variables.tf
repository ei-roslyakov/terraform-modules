variable "records" {
  description = "A map of record with parameters"
  type = map(object({
    zone_id         = optional(string, "")
    name            = optional(string, "")
    type            = optional(string, "")
    ttl             = optional(string, "300")
    values          = optional(list(string))
    health_check_id = optional(string, "")
    allow_overwrite = optional(bool, false)

  }))
  default = {}
}
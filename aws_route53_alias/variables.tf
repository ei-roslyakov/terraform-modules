variable "records" {
  description = "A map of record with parameters"
  type = map(object({
    name                   = optional(string, "")
    zone_id                = optional(string, "")
    zone_name              = optional(string, "")
    private_zone           = optional(bool, false)
    allow_overwrite        = optional(bool, false)
    target_dns_name        = optional(string)
    target_zone_id         = optional(string)
    evaluate_target_health = optional(bool, false)
  }))
  default = {}
}
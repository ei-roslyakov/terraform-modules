
variable "images" {
  description = "A map of images with parameters"
  type = map(object({
    name                 = optional(string)
    image_tag_mutability = optional(string, "MUTABLE")
    scan_on_push         = optional(bool, false)

    lifecycle_policy = optional(object({
      max_image_count = string
      protected_tags  = list(string)
    }))

  }))
  default = {}
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
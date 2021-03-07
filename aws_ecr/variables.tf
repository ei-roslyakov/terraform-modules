variable "scan_images_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  default     = true
}
variable "image_names" {
  type        = list(string)
  default     = []
  description = "List of Docker local image names, used as repository names for AWS ECR "
}
variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
}
variable "protected_tags" {
  type        = set(string)
  description = "Name of image tags prefixes that should not be destroyed. Useful if you tag images with names like `dev`, `staging`, and `prod`"
  default     = []
}
variable "max_image_count" {
  type        = number
  description = "How many Docker Image versions AWS ECR will store"
  default     = 500
}
variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
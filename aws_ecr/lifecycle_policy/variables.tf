
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

variable "aws_ecr_repository_name" {
  type        = string
  default     = ""
  description = "Name of the repository."
}
variable "name" {
  type        = string
  description = "The user's name"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path in which to create the user."
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices."
}

variable "password_reset_required" {
  type        = bool
  default     = true
  description = "Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation."
}

variable "password_length" {
  type        = string
  default     = "20"
  description = "The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "user_policy_attachment" {
  type        = list(string)
  default     = []
  description = "The ARN of the policy you want to apply"
}
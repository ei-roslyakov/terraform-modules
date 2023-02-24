variable "attach_admin_policy" {
  default     = false
  description = "Flag to enable/disable the attachment of the AdministratorAccess policy."
  type        = bool
}

variable "attach_read_only_policy" {
  default     = true
  description = "Flag to enable/disable the attachment of the ReadOnly policy."
  type        = bool
}

variable "force_detach_policies" {
  default     = false
  description = "Flag to force detachment of policies attached to the IAM role."
  type        = bool
}

variable "github_repositories" {
  description = "List of GitHub organization/repository names authorized to assume the role."
  type        = list(string)
}

variable "iam_role_name" {
  default     = "github"
  description = "Name of the IAM role to be created. This will be assumable by GitHub."
  type        = string
}

variable "iam_role_path" {
  default     = "/"
  description = "Path under which to create IAM role."
  type        = string
}

variable "iam_role_permissions_boundary" {
  default     = ""
  description = "ARN of the permissions boundary to be used by the IAM role."
  type        = string
}

variable "iam_role_policy_arns" {
  default     = []
  description = "List of IAM policy ARNs to attach to the IAM role."
  type        = list(string)
}

variable "iam_role_inline_policies" {
  default     = {}
  description = "Inline policies map with policy name as key and json as value."
  type        = map(string)
}

variable "max_session_duration" {
  default     = 3600
  description = "Maximum session duration in seconds."
  type        = number

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "Maximum session duration must be between 3600 and 43200 seconds."
  }
}

variable "tags" {
  default     = {}
  description = "Map of tags to be applied to all resources."
  type        = map(string)
}

variable "name" {
  description = "Prefix (eg. abc) of the instance profile (abcProfile) and role (abcRole) names"
  type        = string
}

variable "policy_jsons" {
  description = "Valid JSON policies for the role"
  type        = list(any)
  default     = []
}

variable "policy_arns" {
  description = "ARNs of IAM policies for the role"
  type        = list(any)
  default     = []
}

variable "attach_ssm_policy" {
  description = "Toggles attachment of the AmazonSSMManagedInstanceCore policy to allow usage of AWS SSM"
  type        = string
  default     = false
}

variable "attach_cwagent_policy" {
  description = "Toggles attachment of the CloudWatchAgentServerPolicy policy to allow usage of CloudWatch agent"
  type        = string
  default     = false
}

variable "path" {
  description = "Path for the instance profile, role and user-managed policy (if any)"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags that should be assigned to the created resources whenever possible"
  type        = map(string)
  default     = {}
}
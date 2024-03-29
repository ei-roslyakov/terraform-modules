variable "public_key_comment" {
  default     = ""
  description = "An optional comment about the public key."
  type        = string
}

variable "pub_key_file" {
  default     = "public_key.pem"
  description = "The encoded public key that you want to add to CloudFront to use with features like field-level encryption."
  type        = string
}

variable "public_key_name" {
  default     = ""
  description = "The name for the public key. By default generated by Terraform."
  type        = string
}

variable "key_group_comment" {
  default     = ""
  description = "A comment to describe the key group."
  type        = string
}

variable "key_group_name" {
  default     = ""
  description = "A name to identify the key group."
  type        = string
}

variable "create_pub_key_secret" {
  type        = bool
  default     = false
  description = "Add the pub key to the secret manager?"
}

variable "secret_name" {
  default     = ""
  description = " (Optional) Friendly name of the new secret."
  type        = string
}

variable "secret_string" {
  default     = ""
  description = "(Optional) Specifies text data that you want to encrypt and store in this version of the secret. This is required if secret_binary is not set."
  type        = string
}

variable "secret_binary" {
  default     = ""
  description = "(Optional) Specifies binary data that you want to encrypt and store in this version of the secret. This is required if secret_string is not set. Needs to be encoded to base64."
  type        = string
}


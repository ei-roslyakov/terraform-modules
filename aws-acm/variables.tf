variable "enabled" {
  description = "Controls if cert should be requested"
  type        = bool
  default     = true
}
variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"
}
variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "Method to use for validation, DNS or EMAIL"
}
variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "A list of domains that should be SANs in the issued certificate"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
variable "wait_for_certificate_issued" {
  type        = bool
  default     = false
  description = "Whether to wait for the certificate to be issued by ACM (the certificate status changed from `Pending Validation` to `Issued`)"
}
variable "domain_validation_options_set" {
  #   type        = string
  description = "Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  default     = ""
}
variable "zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  default     = ""
}

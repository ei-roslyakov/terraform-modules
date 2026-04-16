variable "type" {
  type        = string
  default     = ""
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. "
}

variable "ttl" {
  type        = string
  default     = ""
  description = "(Required for non-alias records) The TTL of the record."
}

variable "name" {
  type        = string
  default     = ""
  description = "The name of the record."
}

variable "values" {
  type        = list(string)
  default     = []
  description = "(Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g. \"first255characters\"\"morecharacters\")."
}

variable "health_check_id" {
  type        = string
  default     = ""
  description = "The health check the record should be associated with."
}

variable "allow_overwrite" {
  type        = bool
  default     = false
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
}

variable "zone_id" {
  type        = string
  description = "Zone ID."
}
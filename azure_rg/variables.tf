# Resource Group Variables

variable "rg_name" {
  description = "The Name of the Resource Group"
  type        = string
}

variable "rg_location" {
  description = "The Azure Region where the Resource Group should exist"
  type        = string
}

variable "rg_tags" {
  description = "A mapping of tags which should be assigned to all resources"
  type        = map(any)
  default     = {}
}

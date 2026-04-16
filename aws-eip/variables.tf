variable "name" {
  description = "Name of the EIP resource"
  type        = string
  default     = ""
}
variable "vpc" {
  description = "Boolean if the EIP is in a VPC or not"
  type        = bool
  default     = null
}
variable "count_eip" {
  description = "Quantity of eip that will be created"
  type        = string
  default     = ""
}
variable "instance" {
  description = "EC2 instance ID"
  type        = string
  default     = null
}
variable "network_interface" {
  description = "Network interface ID to associate with"
  type        = string
  default     = null
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags`"
}

variable "instance_enabled" {
  description = "Flag to control the instance creation. Set to false if it is necessary to skip instance creation"
  default     = "true"
}
variable "assign_eip_address" {
  description = "Assign an Elastic IP address to the instance"
  default     = false
}
variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = false
}
variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}
variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "The type of the instance"
  default     = "t2.micro"
}
variable "ssh_key_pair" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}
variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}
variable "availability_zone" {
  description = "Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region"
  default     = ""
}
variable "private_ip" {
  description = "Private IP address to associate with the instance in the VPC"
  default     = ""
}
variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}
variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = ""
}
variable "security_group" {
  description = "List of Security Group IDs"
  default     = []
}
variable "disable_api_termination" {
  description = "Enable EC2 Instance Termination Protection"
  default     = "false"
}
variable "ipv6_address_count" {
  description = "Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet"
  default     = "0"
}
variable "ebs_optimized" {
  description = "Launched EC2 instance will be EBS-optimized"
  default     = "false"
}
variable "ipv6_addresses" {
  description = "List of IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = []
}
variable "vpc_id" {
  description = "The ID of the VPC that the instance security group belongs to"
}
variable "allowed_ports" {
  description = "List of allowed ingress ports"
  default     = []
}
variable "defaulf_sg_source_security_group_id" {
  description = "The IDs of the security groups that will be added to sg rule"
  default     = ""
}
variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}
variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}
variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = ""
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}
variable "create_default_security_group" {
  description = "Create default Security Group with only Egress traffic allowed"
  default     = "true"
}

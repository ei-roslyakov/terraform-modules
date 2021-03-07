variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}
variable "aws_profile" {
  default = ""
}
variable "create_elasticache" {
  description = "Controls if Redis resources should be created"
  type        = bool
  default     = true
}
variable "multi_az_enabled" {
  description = "Enable_multi_az"
  type        = bool
  default     = true
}
variable "source_security_groups" {
  description = "The IDs of the security groups"
  type        = string
  default     = ""
}
variable "alarm_cpu_threshold" {
  default = "75"
}
variable "alarm_memory_threshold" {
  # 10MB
  default = "10000000"
}
variable "tg_unhealthy_ok_actions" {
  description = "arn for sns topic"
  default     = ""
}
variable "tg_unhealthy_alarm_actions" {
  description = "arn for sns topic"
  default     = ""
}
variable "treat_missing_data" {
  default = "breaching"
}
variable "elasticache_clustes_name" {
  type    = string
  default = ""
}
variable "elasticache_subnet_group_name" {
  type    = string
  default = "redis-subnet-group"
}
variable "engine_version" {
  type    = string
  default = "6.x"
}
variable "elasticache_redis_port" {
  type    = string
  default = 6379
}
variable "num_cache_nodes" {
  type    = string
  default = "2"
}
variable "node_type" {
  type    = string
  default = "cache.t3.medium"
}
variable "engine" {
  type    = string
  default = "redis"
}
variable "snapshot_retention_limit" {
  default = 1
}
variable "az_mode" {
  type    = string
  default = "cross-az"
}
variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}
variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
variable "subnets" {
  type        = list(string)
  description = "Subnet IDs"
  default     = []
}
variable "jenkins_cidr" {
  description = "The Jenkins subnet CIDR block"
  type        = string
  default     = ""
}
variable "jenkins_acces" {
  description = "Create ingress role for Jenkins?"
  type        = bool
  default     = false
}
variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = null
}
variable "source_sg_name" {
  description = "Source SG"
  type        = string
  default     = ""
}
variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group."
  type        = bool
  default     = true
}
variable "enable_alerts" {
  description = "Enable CloudWatch alarms"
  type        = bool
  default     = true
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
  type        = list(string)
  default     = []
}

variable "alarm_cpu_threshold" {
  description = "CPU threshold for the alarm"
  default     = "75"
}

variable "alarm_memory_threshold" {
  description = "Memory threshold for the alarm"
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
  description = "treat missing data"
  default     = "breaching"
}

variable "elasticache_clustes_name" {
  description = "The name of the ElastiCache cluster"
  type        = string
  default     = ""
}

variable "elasticache_subnet_group_name" {
  description = "The name of the ElastiCache subnet group"
  type        = string
  default     = "redis-subnet-group"
}

variable "engine_version" {
  description = "The version of the ElastiCache cluster"
  type        = string
  default     = "6.x"
}

variable "elasticache_redis_port" {
  description = "The port of the ElastiCache cluster"
  type        = string
  default     = 6379
}

variable "num_cache_clusters" {
  description = "The number of cache nodes in the ElastiCache cluster"
  type        = string
  default     = "2"
}

variable "node_type" {
  description = "The node type of the ElastiCache cluster"
  type        = string
  default     = "cache.t3.medium"
}

variable "engine" {
  description = "The engine of the ElastiCache cluster"
  type        = string
  default     = "redis"
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache retains automatic snapshots before deleting them"
  type        = string
  default     = "1"
}

variable "az_mode" {
  description = "The availability zone mode of the ElastiCache cluster"
  type        = string
  default     = "cross-az"
}

variable "preferred_cache_cluster_azs" {
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

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks allowed to access the cluster"
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
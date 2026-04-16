variable "create_elasticsearch" {
  description = "Controls if Elasticsearch resources should be created"
  type        = bool
  default     = true
}
variable "enabling_cloudwatch_monitoring" {
  description = "To enable CloudWatch monitoring"
  type        = bool
  default     = true
}
variable "create_iam_service_linked_role" {
  type        = bool
  default     = true
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}
variable "es_domain_name" {
  type        = string
  description = "Elasticsearch domain name"
  default     = ""
}
variable "dedicated_master_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}
variable "dedicated_master_count" {
  type        = number
  description = "Number of dedicated master nodes in the cluster"
  default     = 0
}
variable "dedicated_master_type" {
  type        = string
  default     = "t2.medium.elasticsearch"
  description = "Instance type of the dedicated master nodes in the cluster"
}
variable "zone_awareness_enabled" {
  default     = true
  description = "Indicates whether zone awareness is enabled, set to true for multi-az deployment"
}
variable "automated_snapshot_start_hour" {
  type        = number
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 0
}
variable "instance_count" {
  type    = string
  default = "2"
}
variable "availability_zone_count" {
  type        = string
  description = "Number of Availability Zones for the domain to use with zone_awareness_enabled."
  default     = "2"
}
variable "source_security_groups" {
  description = "The IDs of the security groups"
  type        = string
  default     = ""
}
variable "elasticsearch_version" {
  type    = string
  default = "7.4"
}
variable "instance_type" {
  default = "t2.medium.elasticsearch"
}
variable "ebs_enabled" {
  default = true
}
variable "volume_type" {
  default = "gp2"
}
variable "volume_size" {
  default = 40
}
variable "subnet_ids" {
  type        = list(string)
  description = "VPC Subnet IDs"
  default     = []
}
variable "elasticsearch_port" {
  type    = string
  default = "443"
}
variable "tags" {
  type    = map(string)
  default = {}
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
variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks allowed to access the cluster"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}
variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = null
}
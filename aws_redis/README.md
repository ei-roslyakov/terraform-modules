## Usage

```hcl
module "aws_redis" {
  source = "./modules/aws_redis"

  create_elasticache         = true
  multi_az_enabled           = true
  automatic_failover_enabled = false
  elasticache_clustes_name   = "temp-cluster"
  node_type                  = "cache.t3.medium"
  vpc_id                     = "vpc_id"
  subnet_ids                 = "subnets-ids"
  source_security_groups     = "source_security_groups"
  allowed_cidr_blocks        = "192.168.1.0/24"
  num_cache_nodes            = "1" # if cross-az should be more than 1
  az_mode                    = "single-az" # by default = "cross-az"
  tags                       = {
    Terraform   = "true"
    Environment = "dev"
    Region      = "some rigion"
  }
  tg_unhealthy_ok_actions    = "arn_sns_actions"
  tg_unhealthy_alarm_actions = "arn_sns_actions"
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.cache-cpuutil](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cache-swap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cache_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_elasticache_replication_group.redis_replication_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.redis_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.redis-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_cpu_threshold"></a> [alarm\_cpu\_threshold](#input\_alarm\_cpu\_threshold) | n/a | `string` | `"75"` | no |
| <a name="input_alarm_memory_threshold"></a> [alarm\_memory\_threshold](#input\_alarm\_memory\_threshold) | n/a | `string` | `"10000000"` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks allowed to access the cluster | `list(string)` | `[]` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. | `bool` | `true` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | `""` | no |
| <a name="input_az_mode"></a> [az\_mode](#input\_az\_mode) | n/a | `string` | `"cross-az"` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | A list of availability zones names or ids in the region | `list(string)` | `[]` | no |
| <a name="input_create_elasticache"></a> [create\_elasticache](#input\_create\_elasticache) | Controls if Redis resources should be created | `bool` | `true` | no |
| <a name="input_elasticache_clustes_name"></a> [elasticache\_clustes\_name](#input\_elasticache\_clustes\_name) | n/a | `string` | `""` | no |
| <a name="input_elasticache_redis_port"></a> [elasticache\_redis\_port](#input\_elasticache\_redis\_port) | n/a | `string` | `6379` | no |
| <a name="input_elasticache_subnet_group_name"></a> [elasticache\_subnet\_group\_name](#input\_elasticache\_subnet\_group\_name) | n/a | `string` | `"redis-subnet-group"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | n/a | `string` | `"redis"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `string` | `"6.x"` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Enable\_multi\_az | `bool` | `true` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | n/a | `string` | `"cache.t3.medium"` | no |
| <a name="input_num_cache_nodes"></a> [num\_cache\_nodes](#input\_num\_cache\_nodes) | n/a | `string` | `"2"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `""` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | n/a | `number` | `1` | no |
| <a name="input_source_security_groups"></a> [source\_security\_groups](#input\_source\_security\_groups) | The IDs of the security groups | `string` | `""` | no |
| <a name="input_source_sg_name"></a> [source\_sg\_name](#input\_source\_sg\_name) | Source SG | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet IDs | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_tg_unhealthy_alarm_actions"></a> [tg\_unhealthy\_alarm\_actions](#input\_tg\_unhealthy\_alarm\_actions) | arn for sns topic | `string` | `""` | no |
| <a name="input_tg_unhealthy_ok_actions"></a> [tg\_unhealthy\_ok\_actions](#input\_tg\_unhealthy\_ok\_actions) | arn for sns topic | `string` | `""` | no |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | n/a | `string` | `"breaching"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_address"></a> [endpoint\_address](#output\_endpoint\_address) | Redis primary endpoint |
| <a name="output_member_clusters"></a> [member\_clusters](#output\_member\_clusters) | Cache clusters |
<!-- END_TF_DOCS -->
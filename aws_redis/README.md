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
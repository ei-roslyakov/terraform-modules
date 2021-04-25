## Usage

```hcl
module "aws_elasticsearch" {
  source = "./modules/aws_elasticsearch"

  create_elasticsearch            = true  
  enabling_cloudwatch_monitoring  = true # create cloudwatch alarms
  allowed_cidr_blocks             = "192.168.1.0/24"
  es_domain_name                  = "cluster_domain_name"
  zone_awareness_enabled          = false
  instance_count                  = "1"
  availability_zone_count         = "1"
  volume_size                     = 30
  vpc_id                          = "vpc_id"
  subnet_ids                      = "subnets-ids"
  source_security_groups          = "source_security_groups"
  tg_unhealthy_ok_actions         = "arn_sns_actions"
  tg_unhealthy_alarm_actions      = "arn_sns_actions"
  tags                            = {
    Terraform   = "true"
    Environment = "dev"
    Region      = "dev"
  }
}
```

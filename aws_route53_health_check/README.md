## Usage

```hcl
provider "aws" {
  profile = "profile"
  alias  = "us-east-1"
  region = "us-east-1"
}

module "health_check" {
  source                    = "./aws_route53_health_check"
  fqdn                      = "exapple.com"
  port                      = 443
  type                      = "HTTPS"
  resource_path             = "/en/store"
  failure_threshold         = "5"
  request_interval          = "30"
  ok_actions                = "ok_actions.arn"
  alarm_actions             = "alarm_actions.arn"
  insufficient_data_actions = "insufficient_data_actions.arn"
  name                      = "exapple"

  providers = {
    aws = aws.us-east-1
  }
}
```

## Please be notified that you have to create cloudwatch alarm in us-east-1 region
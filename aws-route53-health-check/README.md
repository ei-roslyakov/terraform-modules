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
| [aws_cloudwatch_metric_alarm.alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_route53_health_check.check](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN) | `string` | `""` | no |
| <a name="input_cloudwatch_alarm_region"></a> [cloudwatch\_alarm\_region](#input\_cloudwatch\_alarm\_region) | The CloudWatchRegion that the CloudWatch alarm was created in. | `string` | `""` | no |
| <a name="input_failure_threshold"></a> [failure\_threshold](#input\_failure\_threshold) | The number of consecutive health checks that an endpoint must pass or fail | `string` | `""` | no |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | The fully qualified domain name of the endpoint to be checked | `bool` | `false` | no |
| <a name="input_insufficient_data_actions"></a> [insufficient\_data\_actions](#input\_insufficient\_data\_actions) | The list of actions to execute when this alarm transitions into an INSUFFICIENT\_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN) | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the check | `bool` | `false` | no |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN) | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | The port of the endpoint to be checked | `bool` | `false` | no |
| <a name="input_request_interval"></a> [request\_interval](#input\_request\_interval) | The number of seconds between the time that Amazon Route 53 gets a response from your endpoint and the time that it sends the next health-check request. | `string` | `""` | no |
| <a name="input_resource_path"></a> [resource\_path](#input\_resource\_path) | The path that you want Amazon Route 53 to request when performing health checks. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP\_STR\_MATCH, HTTPS\_STR\_MATCH, TCP, CALCULATED and CLOUDWATCH\_METRIC | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
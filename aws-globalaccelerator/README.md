## Usage

```hcl
module "globalaccelerator" {
  source = "./aws_globalaccelerator"

  create_globalaccelerator_accelerator = true
  name                                 = "somename"
  create_elb_listener                  = true
  endpoint_group_region                = "eu-west-2"
  endpoint_configuration = {
    endpoint_id = data.aws_lb.test.arn
    weight      = 100
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
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
| [aws_globalaccelerator_accelerator.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_accelerator) | resource |
| [aws_globalaccelerator_endpoint_group.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_endpoint_group) | resource |
| [aws_globalaccelerator_endpoint_group.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_endpoint_group) | resource |
| [aws_globalaccelerator_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_listener) | resource |
| [aws_globalaccelerator_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_elb_listener"></a> [create\_elb\_listener](#input\_create\_elb\_listener) | Whether to add var.elb\_endpoint to global accelerator endpoints | `bool` | `true` | no |
| <a name="input_create_globalaccelerator_accelerator"></a> [create\_globalaccelerator\_accelerator](#input\_create\_globalaccelerator\_accelerator) | Controls if Globalaccelerator resources should be created | `bool` | `true` | no |
| <a name="input_create_route53_record"></a> [create\_route53\_record](#input\_create\_route53\_record) | n/a | `bool` | `false` | no |
| <a name="input_endpoint_configuration"></a> [endpoint\_configuration](#input\_endpoint\_configuration) | The list of endpoint objects. | `any` | n/a | yes |
| <a name="input_endpoint_group_region"></a> [endpoint\_group\_region](#input\_endpoint\_group\_region) | The name of the AWS Region where the endpoint group is located. | `string` | `""` | no |
| <a name="input_flow_logs_enabled"></a> [flow\_logs\_enabled](#input\_flow\_logs\_enabled) | Indicates whether flow logs are enabled. Defaults to false | `bool` | `false` | no |
| <a name="input_flow_logs_s3_bucket"></a> [flow\_logs\_s3\_bucket](#input\_flow\_logs\_s3\_bucket) | The name of the Amazon S3 bucket for the flow logs. Required if flow\_logs\_enabled is true | `string` | `""` | no |
| <a name="input_flow_logs_s3_prefix"></a> [flow\_logs\_s3\_prefix](#input\_flow\_logs\_s3\_prefix) | The prefix for the location in the Amazon S3 bucket for the flow logs. Required if flow\_logs\_enabled is true | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_route53_record_name"></a> [route53\_record\_name](#input\_route53\_record\_name) | [Optional] DNS name of the global accelerator to be added to route53 zone | `string` | `""` | no |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | [Optional] route53 zone id | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_globalaccelerator_ips"></a> [globalaccelerator\_ips](#output\_globalaccelerator\_ips) | IPs of global accelerator |
<!-- END_TF_DOCS -->
## Usage

```hcl
provider "aws" {
  profile = "sph-dev"
  region  = "eu-west-2"
}


module "sns" {
  source = "./aws_sns"

  name = "temp"
  subscribers = {
    opsgenie = {
      protocol               = "email"
      endpoint               = "eugene.roslyakov@example.com"
      endpoint_auto_confirms = true
      raw_message_delivery   = false
    }
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
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
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_aws_services_for_sns_published"></a> [allowed\_aws\_services\_for\_sns\_published](#input\_allowed\_aws\_services\_for\_sns\_published) | AWS services that will have permission to publish to SNS topic. Used when no external json policy is used. | `list(string)` | <pre>[<br>  "cloudwatch.amazonaws.com"<br>]</pre> | no |
| <a name="input_allowed_iam_arns_for_sns_publish"></a> [allowed\_iam\_arns\_for\_sns\_publish](#input\_allowed\_iam\_arns\_for\_sns\_publish) | IAM role/user ARNs that will have permission to publish to SNS topic. Used when no external json policy is used. | `list(string)` | `[]` | no |
| <a name="input_delivery_policy"></a> [delivery\_policy](#input\_delivery\_policy) | The SNS delivery policy as JSON. | `string` | `null` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | `""` | no |
| <a name="input_sns_topic_policy_json"></a> [sns\_topic\_policy\_json](#input\_sns\_topic\_policy\_json) | The fully-formed AWS policy as JSON | `string` | `""` | no |
| <a name="input_subscribers"></a> [subscribers](#input\_subscribers) | Required configuration for subscibres to SNS topic. | <pre>map(object({<br>    protocol = string<br>    # The protocol to use. The possible values for this are: sqs, sms, lambda, application. (http or https are partially supported, see below) (email is an option but is unsupported, see below).<br>    endpoint = string<br>    # The endpoint to send data to, the contents will vary with the protocol. (see below for more information)<br>    endpoint_auto_confirms = bool<br>    # Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty (default is false)<br>    raw_message_delivery = bool<br>    # Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) (default is false)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | SNS topic ARN |
| <a name="output_aws_sns_topic_subscriptions"></a> [aws\_sns\_topic\_subscriptions](#output\_aws\_sns\_topic\_subscriptions) | SNS topic subscriptions |
| <a name="output_sns_topic"></a> [sns\_topic](#output\_sns\_topic) | SNS topic |
<!-- END_TF_DOCS -->
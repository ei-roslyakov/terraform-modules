## Usage

```hcl
data "aws_route53_zone" "example_com" {
  name         = "example.com"
  private_zone = false
}

module "route53_example_com" {
  source = "./aws_route53_record"

  for_each = var.example_com

  zone_id = data.aws_route53_zone.example_com.id
  name    = each.key
  type    = "A"
  ttl     = "3600"
  values  =  each.value

}

variable "records_example_com" {
  description = "records for example.com domain"
  type        = any
  default = {
    "temp-record" = "213.110.148.240"
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
| [aws_route53_record.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | An alias block. Conflicts with ttl & records. Alias record documented below. | `map(any)` | `{}` | no |
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments. | `bool` | `false` | no |
| <a name="input_health_check_id"></a> [health\_check\_id](#input\_health\_check\_id) | The health check the record should be associated with. | `string` | `""` | no |
| <a name="input_multivalue_answer_routing_policy"></a> [multivalue\_answer\_routing\_policy](#input\_multivalue\_answer\_routing\_policy) | Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy. | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the record. | `string` | `""` | no |
| <a name="input_record_enabled"></a> [record\_enabled](#input\_record\_enabled) | Whether to create Route53 record set. | `bool` | `true` | no |
| <a name="input_set_identifier"></a> [set\_identifier](#input\_set\_identifier) | Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below. | `string` | `null` | no |
| <a name="input_simple_record"></a> [simple\_record](#input\_simple\_record) | To create simple record record | `bool` | `false` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | (Required for non-alias records) The TTL of the record. | `string` | `""` | no |
| <a name="input_type"></a> [type](#input\_type) | The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. | `string` | `""` | no |
| <a name="input_values"></a> [values](#input\_values) | (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add "" inside the Terraform configuration string (e.g. "first255characters""morecharacters"). | `string` | `""` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Zone ID. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
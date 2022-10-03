## Usage

```hcl
module "request_cert" {
  source = "./aws_acm_request_cert"

  domain_name = "subdomain.yourdomain.com"
  validation_method = "DNS"
}

module "validation" {
  source = "./aws_acm_validate_cert"

  zone_name       = "yourdomain.com"
  wait_for_certificate_issued = true
  certificate_arn = module.cert.arn
  
  name = module.cert.resource_record_name
  type = module.cert.resource_record_type
  records = module.cert.resource_record_value
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
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | A domain name for which the certificate should be issued | `string` | n/a | yes |
| <a name="input_domain_validation_options_set"></a> [domain\_validation\_options\_set](#input\_domain\_validation\_options\_set) | Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Controls if cert should be requested | `bool` | `true` | no |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | A list of domains that should be SANs in the issued certificate | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_validation_method"></a> [validation\_method](#input\_validation\_method) | Method to use for validation, DNS or EMAIL | `string` | `"DNS"` | no |
| <a name="input_wait_for_certificate_issued"></a> [wait\_for\_certificate\_issued](#input\_wait\_for\_certificate\_issued) | Whether to wait for the certificate to be issued by ACM (the certificate status changed from `Pending Validation` to `Issued`) | `bool` | `false` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The Hosted Zone ID. This can be referenced by zone records. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the certificate |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The ID of the certificate |
| <a name="output_domain_validation_options"></a> [domain\_validation\_options](#output\_domain\_validation\_options) | Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the certificate |
<!-- END_TF_DOCS -->
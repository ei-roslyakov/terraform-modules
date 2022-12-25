## Usage

```hcl
inputs = {
  bucket  = "bucket-id"
  iam_arn = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity XXXXXXXXXXXXXXXXX"
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
| [aws_s3_bucket_policy.allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the bucket to which to apply the policy. | `string` | `""` | no |
| <a name="input_iam_arn"></a> [iam\_arn](#input\_iam\_arn) | A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
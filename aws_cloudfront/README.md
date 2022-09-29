## Usage

```hcl
module "cloudfront" {
  source = "./aws_cloudfront"

  create_cloudfront = true
  create_record     = true
  private_zone      = true

  zone_name         = "ireland.prod"
  aliases           = ["cdn-irl.ireland.prod"]
  bucket_name       = module.s3-ireland-prod.s3_bucket_id
  s3_bucket_arn     = module.s3-ireland-prod.s3_bucket_arn

  viewer_certificate = {
    acm_certificate_arn = "arn:aws:acm:us-east-1:673182026046:certificate/5b05de2e-0d76-47d5-ba8f-895af148d51e"
    ssl_support_method  = "sni-only"
  }

  forward_headers = [
    "Access-Control-Request-Headers",
    "Access-Control-Request-Method",
    "Origin",
  ]

  realtime_logging_config = {
    name               = "sph-dev-cdn-realtime-logs"
    sampling_rate      = 80
    fields             = ["timestamp", "cs-method", "cs-uri-stem", "sc-status", "cs-uri-query", "sc-content-type", "cs-headers"]
    kinesis_stream_arn = var.kinesis_stream_arn
  }

  bucket_regional_domain_name = module.s3-ireland-prod.s3_bucket_bucket_regional_domain_name

  tags       = var.tags
  depends_on = [module.s3-ireland-prod]
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
| [aws_cloudfront_distribution.cloudfront_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_cloudfront_realtime_log_config.realtime_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_realtime_log_config) | resource |
| [aws_iam_role.cloudfront_realtime_log_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket_policy.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_iam_policy_document.s3_policy_documen](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliases"></a> [aliases](#input\_aliases) | Extra CNAMEs (alternate domain names), if any, for this distribution. | `list(string)` | `null` | no |
| <a name="input_allowed_methods"></a> [allowed\_methods](#input\_allowed\_methods) | n/a | `list` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket\_name | `any` | `null` | no |
| <a name="input_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#input\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL. | `string` | `""` | no |
| <a name="input_cache_policy_id"></a> [cache\_policy\_id](#input\_cache\_policy\_id) | ID of the cache policy attached to the cache behavior | `string` | `null` | no |
| <a name="input_cached_methods"></a> [cached\_methods](#input\_cached\_methods) | n/a | `list` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_compress"></a> [compress](#input\_compress) | Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false). | `bool` | `true` | no |
| <a name="input_create_cloudfront"></a> [create\_cloudfront](#input\_create\_cloudfront) | Controls if cloudfront\_distribution resources should be created | `bool` | `true` | no |
| <a name="input_create_record"></a> [create\_record](#input\_create\_record) | Controls if route53 record resources should be created | `bool` | `false` | no |
| <a name="input_custom_header"></a> [custom\_header](#input\_custom\_header) | List of one or more custom headers passed to the origin | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_evaluate_target_health"></a> [evaluate\_target\_health](#input\_evaluate\_target\_health) | Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. Some resources have special requirements | `bool` | `false` | no |
| <a name="input_forward_cookies"></a> [forward\_cookies](#input\_forward\_cookies) | Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist | `string` | `"none"` | no |
| <a name="input_forward_cookies_whitelisted_names"></a> [forward\_cookies\_whitelisted\_names](#input\_forward\_cookies\_whitelisted\_names) | List of forwarded cookie names | `list(string)` | `[]` | no |
| <a name="input_forward_headers"></a> [forward\_headers](#input\_forward\_headers) | Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers. | `list(string)` | `[]` | no |
| <a name="input_forward_query_string"></a> [forward\_query\_string](#input\_forward\_query\_string) | Forward query strings to the origin that is associated with this cache behavior | `bool` | `false` | no |
| <a name="input_headers_cache_keys"></a> [headers\_cache\_keys](#input\_headers\_cache\_keys) | Specifies the cache headers for default cache behavior. | `list(string)` | `[]` | no |
| <a name="input_http_version"></a> [http\_version](#input\_http\_version) | The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2. | `string` | `"http2"` | no |
| <a name="input_is_ipv6_enabled"></a> [is\_ipv6\_enabled](#input\_is\_ipv6\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_logging_config"></a> [logging\_config](#input\_logging\_config) | The logging configuration that controls how logs are written to your distribution (maximum one). | `any` | `{}` | no |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version) | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections | `string` | `"TLSv1.2_2019"` | no |
| <a name="input_origin_path"></a> [origin\_path](#input\_origin\_path) | An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path. | `string` | `""` | no |
| <a name="input_origin_request_policy_id"></a> [origin\_request\_policy\_id](#input\_origin\_request\_policy\_id) | ID of the origin request policy attached to the cache behavior | `string` | `null` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | `"PriceClass_100"` | no |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | Search filter for Route53 zone, if private set true | `bool` | `false` | no |
| <a name="input_realtime_logging_config"></a> [realtime\_logging\_config](#input\_realtime\_logging\_config) | The real-time log configuration that is attached to cache behavior. | <pre>object({<br>    name               = string<br>    sampling_rate      = number<br>    fields             = list(string)<br>    kinesis_stream_arn = string<br>  })</pre> | `null` | no |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | The ARN of the bucket | `string` | `""` | no |
| <a name="input_s3_origin_id"></a> [s3\_origin\_id](#input\_s3\_origin\_id) | n/a | `string` | `""` | no |
| <a name="input_smooth_streaming"></a> [smooth\_streaming](#input\_smooth\_streaming) | Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_viewer_certificate"></a> [viewer\_certificate](#input\_viewer\_certificate) | The SSL configuration for this distribution | `any` | <pre>{<br>  "cloudfront_default_certificate": true,<br>  "minimum_protocol_version": "TLSv1"<br>}</pre> | no |
| <a name="input_viewer_protocol_policy"></a> [viewer\_protocol\_policy](#input\_viewer\_protocol\_policy) | Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https | `string` | `"redirect-to-https"` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The Hosted Zone name of the desired Hosted Zone | `string` | `""` | no |
| <a name="input_zone_record"></a> [zone\_record](#input\_zone\_record) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#output\_cloudfront\_distribution\_arn) | The ARN (Amazon Resource Name) for the distribution. |
| <a name="output_cloudfront_distribution_domain_name"></a> [cloudfront\_distribution\_domain\_name](#output\_cloudfront\_distribution\_domain\_name) | The domain name corresponding to the distribution. |
| <a name="output_cloudfront_distribution_id"></a> [cloudfront\_distribution\_id](#output\_cloudfront\_distribution\_id) | The identifier for the distribution. |
<!-- END_TF_DOCS -->
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

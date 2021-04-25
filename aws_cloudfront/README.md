## Usage

```hcl
source = "./aws_cloudfront"

  create_cloudfront = true
  create_record     = true
  private_zone      = true

  zone_name         = "rpute53_zone_name"
  aliases           = ["aliase"]
  bucket_name       = "bucket_name"
  s3_bucket_arn     = "s3_bucket_arn"

  viewer_certificate = {
    acm_certificate_arn = "certificate_arn"
    ssl_support_method  = "sni-only"
  }

  bucket_regional_domain_name = "bucket_regional_domain_name"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
```

## Usage

```hcl
module "cloudfront" {
  source = "./modules/aws_cloudfront"

  create_cloudfront           = true
  bucket_name                 = "bucket_name"
  s3_bucket_arn               = "s3_bucket_arn
  bucket_regional_domain_name = "bucket_regional_domain_name"

  tags                        = {
    Terraform   = "true"
    Environment = "dev"
    Region      = "dev"
  }
  depends_on                  = [ module.s3_bucket ]
}
```

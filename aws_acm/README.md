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



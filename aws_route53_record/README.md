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
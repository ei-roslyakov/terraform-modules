data "aws_route53_zone" "selected" {
  count = var.zone_name == "" ? 0 : 1

  name         = var.zone_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "record" {
  for_each = toset([for v in var.aliases : tostring(v)])

  zone_id = join(" ", data.aws_route53_zone.selected.*.id)
  name    = each.key
  type    = "A"

  alias {
    name                   = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.domain_name, [""]), 0)
    zone_id                = join(" ", aws_cloudfront_distribution.cloudfront_distribution.*.hosted_zone_id)
    evaluate_target_health = false
  }
}
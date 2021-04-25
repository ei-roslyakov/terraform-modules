data "aws_route53_zone" "selected" {
  count = var.create_record ? 1 : 0

  name         = var.zone_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "record" {
  count = var.create_record && length(var.aliases) > 0 ? 1 : 0

  zone_id = join(" ", data.aws_route53_zone.selected.*.id)
  name    = var.aliases[count.index]
  type    = "A"

  alias {
    name                   = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.domain_name, [""]), 0)
    zone_id                = join(" ", aws_cloudfront_distribution.cloudfront_distribution.*.hosted_zone_id)
    evaluate_target_health = var.evaluate_target_health
  }
}
data "aws_route53_zone" "default" {
  count        = var.zone_id != "" ? 1 : 0
  zone_id      = var.zone_id
  name         = var.zone_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "alias_record" {
  zone_id         = var.zone_id != "" ? var.zone_id : data.aws_route53_zone.default[0].zone_id
  name            = var.name
  allow_overwrite = var.allow_overwrite
  type            = "A"

  alias {
    name                   = var.target_dns_name
    zone_id                = var.target_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}


data "aws_route53_zone" "selected" {
  name         = var.zone_name
  private_zone = true
}

resource "aws_route53_record" "default" {
  count   = var.enabled ? 1 : 0
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.name}.${data.aws_route53_zone.selected.name}"
  type    = var.type
  ttl     = var.ttl
  records = var.records
}

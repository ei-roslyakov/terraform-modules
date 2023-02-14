resource "aws_route53_record" "default" {
  zone_id                          = var.zone_id
  name                             = var.name
  type                             = var.type
  ttl                              = var.ttl
  records                          = var.values
  health_check_id                  = var.health_check_id
  allow_overwrite                  = var.allow_overwrite
}
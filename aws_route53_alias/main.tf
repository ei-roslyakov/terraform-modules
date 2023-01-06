module "record" {

  for_each = var.records

  source = "./aws_alias"

  name = try("${each.value["name"]}", "${each.key}")

  zone_id      = try(each.value["zone_id"], "")
  zone_name    = try(each.value["zone_name"], "")
  private_zone = try(each.value["private_zone"], false)

  allow_overwrite = try(each.value["allow_overwrite"], false)

  target_dns_name        = try(each.value["target_dns_name"], "")
  target_zone_id         = try(each.value["target_zone_id"], "")
  evaluate_target_health = each.value["evaluate_target_health"]

}
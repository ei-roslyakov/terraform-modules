module "record" {

  for_each = var.records

  source = "./aws_record"

  zone_id         = try(each.value["zone_id"], "")
  name            = try(each.value["name"], each.key)
  type            = try(each.value["type"], "")
  ttl             = try(each.value["ttl"], "")
  values          = try(each.value["values"], "")
  health_check_id = try(each.value["health_check_id"], "")
  allow_overwrite = try(each.value["allow_overwrite"], "")
}
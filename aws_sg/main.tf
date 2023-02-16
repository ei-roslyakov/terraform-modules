module "sg" {
  for_each = var.groups

  source                 = "./sg"

  name        = try(each.value["name"], each.key)
  description = try(each.value["description"], each.key)
  vpc_id      = try(each.value["vpc_id"], each.key)

  ingress_rules = try(each.value["ingress_rules"], each.key)
    tags = try(each.value["tags"], each.key)

}
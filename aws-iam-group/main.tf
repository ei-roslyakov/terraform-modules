module "group" {

  for_each = var.groups

  source = "./iam-group-with-policies"

  name              = try(each.value["name"], each.key)
  group_users       = each.value["group_users"]
  group_policy_arns = each.value["group_policy_arns"]
}
module "group" {

  for_each = var.groups

  source = "./iam_group_with_policies"

  name              = try(each.value["name"], each.key)
  group_users       = each.value["group_users"]
  group_policy_arns = each.value["group_policy_arns"]
}
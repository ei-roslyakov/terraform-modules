module "role" {

  for_each = var.roles

  source = "./iam_role"

  name                    = try("${each.value["name"]}", "${each.key}")
  instance_profile_enable = each.value["instance_profile_enable"]
  policy_arns             = try(each.value["policy_arns"], [])

  tags = merge(merge(
    {
      "Name" = try("${each.value["name"]}", "${each.key}")
    },
    each.value["custom_tags"]),
    var.tags
  )
}
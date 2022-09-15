module "user" {
  for_each = var.users

  source                 = "./iam_user"
  name                   = try(each.value["name"], each.key)
  path                   = try(each.value["path"], "/")
  permissions_boundary   = try(each.value["permissions_boundary"], null)
  force_destroy          = try(each.value["force_destroy"], false)
  user_policy_attachment = try(each.value["policy"], [])

  tags = merge(
    {
      "Name" = each.value["name"]
    },
    try(each.value["custom_tags"], null),
    var.tags
  )
}
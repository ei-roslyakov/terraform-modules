data "aws_ssoadmin_instances" "user" {}

resource "aws_identitystore_user" "user" {

  for_each = { for user in var.identitystore_user : user.user_name => user }

  identity_store_id = local.identity_store_id

  display_name = "${each.value.given_name} ${each.value.family_name}"
  user_name    = each.value.user_name

  name {
    given_name  = each.value.given_name
    family_name = each.value.family_name
  }

  emails {
    value   = each.value.email
    primary = true
  }
}

resource "aws_identitystore_group_membership" "group_association" {
  for_each = local.user_group_pairs

  identity_store_id = local.identity_store_id

  group_id  = aws_identitystore_group.group["${each.value.group}"].group_id
  member_id = aws_identitystore_user.user["${each.value.user}"].user_id
}


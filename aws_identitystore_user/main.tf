resource "aws_identitystore_user" "user" {

    for_each = var.identitystore_user

  identity_store_id = tolist(data.aws_ssoadmin_instances.user.identity_store_ids)[0]

  display_name = try(each.value["display_name"], each.key)
  user_name    = each.value["user_name"]

  name {
    given_name    = each.value["given_name"]
    family_name   = each.value["family_name"]
  }

  emails {
    value = each.value["email"]
  }
}


data "aws_ssoadmin_instances" "user" {}
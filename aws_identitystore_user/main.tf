locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.user.identity_store_ids)[0]
}

data "aws_ssoadmin_instances" "user" {}

resource "aws_identitystore_user" "user" {

  for_each = var.identitystore_user

  identity_store_id = local.identity_store_id

  display_name = try(each.value["display_name"], each.key)
  user_name    = each.value["user_name"]

  name {
    given_name  = each.value["given_name"]
    family_name = each.value["family_name"]
  }

  emails {
    value = each.value["email"]
    primary = try(each.value["primary_email"], false)  
  }
}

data "aws_identitystore_user" "user" {
  identity_store_id = local.identity_store_id

   for_each = var.identitystore_user

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = try(each.value["user_name"], each.key)
    }
  }
}
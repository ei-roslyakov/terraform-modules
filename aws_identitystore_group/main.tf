locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.group.identity_store_ids)[0]
}

data "aws_ssoadmin_instances" "group" {}

resource "aws_identitystore_group" "group" {
  for_each = var.identitystore_group

  display_name      = try(each.value["display_name"], each.key)
  description       = each.value["description"]

  identity_store_id = local.identity_store_id
}


data "aws_identitystore_group" "group" {
  identity_store_id = local.identity_store_id

  for_each = var.identitystore_group

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = try(each.value["display_name"], each.key)
    }
  }
  depends_on= [aws_identitystore_group.group] 
}
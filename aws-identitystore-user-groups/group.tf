
resource "aws_identitystore_group" "group" {
  for_each = var.identitystore_group

  display_name = try(each.value["display_name"], each.key)
  description  = each.value["description"]

  identity_store_id = local.identity_store_id
}
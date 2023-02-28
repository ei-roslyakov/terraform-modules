locals {group_id
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  users = { for user in var.identitystore_group_membership : user.group_id => user.user_ids }

  # users1 = { for user in local.users : }
}

data "aws_ssoadmin_instances" "this" {}

resource "aws_identitystore_group_membership" "example" {

  for_each = { for user in var.identitystore_group_membership : user.group_id => user.user_ids }

  identity_store_id = local.identity_store_id
  group_id          = each.key
  member_id         = [for user in each.value : user]
}

# user_id

# data "aws_identitystore_group" "group" {
#   identity_store_id = local.identity_store_id

#   for_each = var.identitystore_group_membership

#   alternate_identifier {
#     unique_attribute {
#       attribute_path  = "DisplayName"
#       attribute_value = each.value["group"]
#     }
#   }
# }

# data "aws_identitystore_user" "user" {
#   identity_store_id = local.identity_store_id

#    for_each = var.identitystore_group_membership

#   alternate_identifier {
#     unique_attribute {
#       attribute_path  = "UserName"
#       attribute_value = each.value["users"]
#     }
#   }
# }
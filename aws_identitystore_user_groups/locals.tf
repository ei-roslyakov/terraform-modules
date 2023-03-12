locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.user.identity_store_ids)[0]

  user_group_pairs = merge([
    for key in var.identitystore_user : {
      for group in key.groups :
      "${key.user_name}-${group}" => {
        user  = key.user_name
        group = group
      }
    }
  ]...)
}
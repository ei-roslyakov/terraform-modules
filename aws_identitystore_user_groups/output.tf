output "user_group_pairs" {
  value = local.user_group_pairs
}

output "groups" {
  value = {
    for group in aws_identitystore_group.group : group.display_name => group.id
  }
}
output "group_name_with_group_id" {
  value = { for group in data.aws_identitystore_group.group : group.display_name => group.group_id }
}

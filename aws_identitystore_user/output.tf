output "user_name_with_user_id" {
  value = { for user in data.aws_identitystore_user.user : user.display_name => user.user_id }
}

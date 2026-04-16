output "user_name_with_arn" {
  description = "IAM user name"
  value       = { for user in module.user : user.iam_user_name => user.iam_user_arn }
}

output "user_name_with_password" {
  description = "IAM user name"
  value       = { for user in module.user : user.iam_user_name => user.iam_user_password }
}

output "user_name_with_unique_id" {
  description = "IAM user name"
  value       = { for user in module.user : user.iam_user_name => user.iam_user_unique_id }
}
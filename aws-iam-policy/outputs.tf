output "policy_name_with_arn" {
  description = "IAM user name"
  value = {
    for policy in aws_iam_policy.policy : policy.name => policy.arn
  }
}

output "policy_name_with_id" {
  description = "IAM user name"
  value = {
    for policy in aws_iam_policy.policy : policy.name => policy.id
  }
}

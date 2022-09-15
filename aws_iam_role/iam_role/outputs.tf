output "name" {
  value       = aws_iam_role.role.name
  description = "The name of the IAM role created"
}

output "id" {
  value       = aws_iam_role.role.unique_id
  description = "The stable and unique string identifying the role"
}

output "arn" {
  value       = aws_iam_role.role.arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "policy" {
  value       = data.aws_iam_policy_document.service-assume-role-policy.json
  description = "Role policy document in json format. Outputs always, independent of `enabled` variable"
}

output "instance_profile" {
  description = "Name of the ec2 profile (if enabled)"
  value       = join("", aws_iam_role.role.*.name)
}
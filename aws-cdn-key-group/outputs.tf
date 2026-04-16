output "caller_reference" {
  description = "Internal value used by CloudFront to allow future updates to the public key configuration."
  value       = aws_cloudfront_public_key.key.caller_reference
}

output "aws_cloudfront_public_key_id" {
  description = "The identifier for the public key."
  value       = aws_cloudfront_public_key.key.id
}

output "aws_cloudfront_key_group_id" {
  description = "The identifier for the key group."
  value       = aws_cloudfront_key_group.key_group.id
}

output "aws_secretsmanager_secret_id" {
  description = "ID of the secret."
  value       = aws_secretsmanager_secret_version.secret_v[0].id
}

output "aws_secretsmanager_secret_arn" {
  description = "ARN of the secret."
  value       = aws_secretsmanager_secret_version.secret_v[0].arn
}

output "caller_reference" {
  description = "Internal value used by CloudFront to allow future updates to the public key configuration."
  value = aws_cloudfront_public_key.key.caller_reference
}

output "id" {
  description = "The identifier for the key group."
  value = aws_cloudfront_key_group.key_group.id
}


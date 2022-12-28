output "caller_reference" {
  description = "Internal value used by CloudFront to allow future updates to the public key configuration."
  value = aws_cloudfront_public_key.key.caller_reference
}


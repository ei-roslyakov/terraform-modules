output "cloudfront_distribution_id" {
  description = "The identifier for the distribution."
  value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.id, [""]), 0)
}
output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.arn, [""]), 0)
}
output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.domain_name, [""]), 0)
}

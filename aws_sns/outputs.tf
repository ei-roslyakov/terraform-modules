output "sns_topic" {
  value       = aws_sns_topic.this
  description = "SNS topic"
}

output "arn" {
  value       = aws_sns_topic.this.arn
  description = "SNS topic ARN"
}

output "aws_sns_topic_subscriptions" {
  value       = aws_sns_topic_subscription.this
  description = "SNS topic subscriptions"
}

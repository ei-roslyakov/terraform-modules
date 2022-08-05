data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "this" {
  name              = var.name
  display_name      = var.name
  kms_master_key_id = var.kms_master_key_id
  delivery_policy   = var.delivery_policy

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_sns_topic_subscription" "this" {
  for_each = var.subscribers

  topic_arn              = aws_sns_topic.this.arn
  protocol               = var.subscribers[each.key].protocol
  endpoint               = var.subscribers[each.key].endpoint
  endpoint_auto_confirms = var.subscribers[each.key].endpoint_auto_confirms
  raw_message_delivery   = var.subscribers[each.key].raw_message_delivery
}

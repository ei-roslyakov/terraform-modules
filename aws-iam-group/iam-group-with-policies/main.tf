locals {
  group_name = element(concat(aws_iam_group.this.*.id, [var.name]), 0)
}

resource "aws_iam_group" "this" {
  count = var.create_group ? 1 : 0

  name = var.name
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = local.group_name
  name  = var.name
  users = var.group_users
}

resource "aws_iam_group_policy_attachment" "custom_arns" {
  count = var.group_policy_arns != null ? length(var.group_policy_arns) : 0

  group      = local.group_name
  policy_arn = element(var.group_policy_arns, count.index)
}

resource "aws_iam_group_policy_attachment" "custom" {
  count = length(var.custom_group_policies)

  group      = local.group_name
  policy_arn = element(aws_iam_policy.custom.*.arn, count.index)
}

resource "aws_iam_policy" "custom" {
  count = length(var.custom_group_policies)

  name        = var.custom_group_policies[count.index]["name"]
  policy      = var.custom_group_policies[count.index]["policy"]
  description = lookup(var.custom_group_policies[count.index], "description", null)

  tags = var.tags
}
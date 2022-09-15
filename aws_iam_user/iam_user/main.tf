resource "aws_iam_user" "user" {
  name                 = var.name
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  force_destroy        = var.force_destroy

  tags = var.tags
}

resource "aws_iam_user_login_profile" "user" {
  user                    = aws_iam_user.user.name
  password_reset_required = var.password_reset_required
  password_length         = var.password_length
  lifecycle {
    ignore_changes = [password_reset_required]
  }
}

resource "aws_iam_user_policy_attachment" "attach" {
  count = var.user_policy_attachment == null ? 0 : length(var.user_policy_attachment)

  user       = aws_iam_user.user.name
  policy_arn = element(var.user_policy_attachment, count.index)
}

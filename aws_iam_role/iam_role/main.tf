data "aws_iam_policy_document" "service-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.principals_type
      identifiers = var.principals_identifiers
    }
  }
}

resource "aws_iam_role" "role" {
  name               = var.name
  path               = var.path
  assume_role_policy = data.aws_iam_policy_document.service-assume-role-policy.json

  tags = var.tags

}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.policy_arns == null ? 0 : length(var.policy_arns)
  role       = aws_iam_role.role.id
  policy_arn = element(var.policy_arns, count.index)
}

resource "aws_iam_instance_profile" "default" {
  count = var.instance_profile_enable ? 1 : 0
  name  = var.name
  role  = aws_iam_role.role.name
}

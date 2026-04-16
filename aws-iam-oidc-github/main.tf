locals {
  github_organizations = toset([for repo in var.github_repositories : split("/", repo)[0]])
  partition            = data.aws_partition.current.partition
}

resource "aws_iam_role" "github" {
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  description           = "Role assumed by the GitHub OIDC provider."
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  name                  = var.iam_role_name
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_role_permissions_boundary
  tags                  = var.tags

}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = toset(var.iam_role_policy_arns)

  policy_arn = each.key
  role       = aws_iam_role.github.id
}

resource "aws_iam_role_policy_attachment" "admin" {
  count = var.attach_admin_policy ? 1 : 0

  policy_arn = "arn:${local.partition}:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.github.id
}

resource "aws_iam_role_policy_attachment" "read_only" {
  count = var.attach_read_only_policy ? 1 : 0

  policy_arn = "arn:${local.partition}:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.github.id
}

resource "aws_iam_openid_connect_provider" "github" {
  client_id_list = concat(
    ["sts.amazonaws.com"],
    [for org in local.github_organizations : "https://github.com/${org}"]
  )
  tags            = var.tags
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
  url             = "https://token.actions.githubusercontent.com"
}

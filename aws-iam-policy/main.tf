resource "aws_iam_policy" "policy" {
  for_each = var.policies

  name        = try("${each.value["name"]}", "${each.key}")
  path        = try(each.value["path"], "/")
  description = try(each.value["description"], try("${each.value["name"]}", "${each.key}"))

  policy = file(each.value["policy_path"])

  tags = merge(
    {
      "Name" = try("${each.value["name"]}", "${each.key}")
    },
    try(each.value["custom_tags"], null),
    var.tags
  )
}
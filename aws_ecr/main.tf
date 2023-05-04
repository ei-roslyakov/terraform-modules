resource "aws_ecr_repository" "ecr_repo" {
  for_each = var.images

  name                 = each.value["name"]
  image_tag_mutability = each.value["image_tag_mutability"]

  image_scanning_configuration {
    scan_on_push = each.value["scan_on_push"]
  }

  tags = merge(
    {
      "Name" = format("%s", each.value["name"])
    },
    var.tags,
  )
}

module "lifecycle_policy" {
  source = "./lifecycle_policy"

  for_each = {
    for key, value in var.images :
    key => value
    if lookup(value, "lifecycle_policy", null) != null
  }
  aws_ecr_repository_name = aws_ecr_repository.ecr_repo[each.key].name

  max_image_count = each.value["lifecycle_policy"]["max_image_count"]
  protected_tags  = each.value["lifecycle_policy"]["protected_tags"]
}

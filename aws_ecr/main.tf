locals {
  untagged_image_rule = [{
    rulePriority = length(var.protected_tags) + 1
    description  = "Remove untagged images"
    selection = {
      tagStatus   = "untagged"
      countType   = "imageCountMoreThan"
      countNumber = 1
    }
    action = {
      type = "expire"
    }
  }]

  remove_old_image_rule = [{
    rulePriority = length(var.protected_tags) + 2
    description  = "Rotate images when reach ${var.max_image_count} images stored",
    selection = {
      tagStatus   = "any"
      countType   = "imageCountMoreThan"
      countNumber = var.max_image_count
    }
    action = {
      type = "expire"
    }
  }]

  protected_tag_rules = [
    for index, tagPrefix in zipmap(range(length(var.protected_tags)), tolist(var.protected_tags)) :
    {
      rulePriority = tonumber(index) + 1
      description  = "Protects images tagged with ${tagPrefix}"
      selection = {
        tagStatus     = "tagged"
        tagPrefixList = [tagPrefix]
        countType     = "imageCountMoreThan"
        countNumber   = 999999
      }
      action = {
        type = "expire"
      }
    }
  ]
}

resource "aws_ecr_repository" "ecr_repo" {
  for_each = toset(var.image_names)

  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_images_on_push
  }

  tags = merge(
    {
      "Name" = format("%s", each.value)
    },
    var.tags,
  )
}

resource "aws_ecr_lifecycle_policy" "ect_policy" {
  for_each   = toset(var.image_names)
  repository = aws_ecr_repository.ecr_repo[each.value].name

  policy = jsonencode({
    rules = concat(local.protected_tag_rules, local.untagged_image_rule, local.remove_old_image_rule)
  })
}
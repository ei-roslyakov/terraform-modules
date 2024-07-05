locals {
  ip_access_list = flatten([
    for project_key, project_value in var.projects : [
      for ip in project_value.ip_access_list : {
        project_key = project_key
        project_id  = mongodbatlas_project.project[project_key].id
        ip_address  = ip.ip_address
        comment     = ip.comment
      }
    ]
  ])

  cidr_block_access_list = flatten([
    for project_key, project_value in var.projects : [
      for cidr_block in project_value.cidr_block_access_list : {
        project_key = project_key
        project_id  = mongodbatlas_project.project[project_key].id
        cidr_block  = cidr_block.cidr_block
        comment     = cidr_block.comment
      }
    ]
  ])

  aws_security_group_access_list = flatten([
    for project_key, project_value in var.projects : [
      for aws_security_group in project_value.aws_security_group_access_list : {
        project_key        = project_key
        project_id         = mongodbatlas_project.project[project_key].id
        aws_security_group = aws_security_group.aws_security_group
        comment            = aws_security_group.comment
      }
    ]
  ])
}

resource "mongodbatlas_project_ip_access_list" "ip_address" {
  for_each = { for idx, ip in local.ip_access_list : "${ip.project_key}-${idx}" => ip }

  project_id = each.value.project_id
  ip_address = each.value.ip_address
  comment    = each.value.comment
}

resource "mongodbatlas_project_ip_access_list" "cidr_block" {
  for_each = { for idx, ip in local.cidr_block_access_list : "${ip.project_key}-${idx}" => ip }

  project_id = each.value.project_id
  cidr_block = each.value.cidr_block
  comment    = each.value.comment
}

resource "mongodbatlas_project_ip_access_list" "sg" {
  for_each = { for idx, ip in local.aws_security_group_access_list : "${ip.project_key}-${idx}" => ip }

  project_id         = each.value.project_id
  aws_security_group = each.value.aws_security_group
  comment            = each.value.comment
}

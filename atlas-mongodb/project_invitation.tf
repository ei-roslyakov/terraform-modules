locals {
  project_access_list = flatten([
    for project_name, project in var.projects : [
      for username, access in project.project_access : {
        username   = access.username,
        project_id = mongodbatlas_project.project[project_name].id,
        role_names = access.role_names
      }
    ]
  ])
}

resource "mongodbatlas_project_invitation" "invitation" {
  for_each = { for idx, access in local.project_access_list : idx => access }

  username   = each.value.username
  project_id = each.value.project_id
  roles      = each.value.role_names
}

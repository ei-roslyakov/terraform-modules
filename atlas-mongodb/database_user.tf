resource "mongodbatlas_database_user" "db_user" {

  for_each = var.database_users

  username           = try(each.value["username"], each.key)
  password           = try(each.value["password"], null)
  project_id         = mongodbatlas_project.project[each.value.project].id
  auth_database_name = try(each.value["auth_database_name"], "admin")

  dynamic "roles" {
    for_each = each.value.roles
    content {
      role_name     = roles.value.role_name
      database_name = roles.value.database_name
    }
  }

  dynamic "labels" {
    for_each = try(each.value["labels"], {})
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }

  dynamic "scopes" {
    for_each = try(each.value["scopes"], {})
    content {
      name = scopes.value.name
      type = scopes.value.type
    }
  }

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

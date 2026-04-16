resource "mongodbatlas_project" "project" {
  for_each = var.projects

  name             = try(each.value["name"], each.key)
  org_id           = var.org_id
  project_owner_id = try(each.value["project_owner_id"], null)

  dynamic "teams" {
    for_each = try(each.value["teams"], {})
    content {
      team_id    = mongodbatlas_team.team[teams.key].team_id
      role_names = teams.value["role_names"]
    }
  }

  dynamic "limits" {
    for_each = each.value["limits"]
    content {
      name  = limits.value["name"]
      value = limits.value["value"]
    }
  }

  is_collect_database_specifics_statistics_enabled = try(each.value["is_collect_database_specifics_statistics_enabled"], false)
  is_data_explorer_enabled                         = try(each.value["is_data_explorer_enabled"], false)
  is_extended_storage_sizes_enabled                = try(each.value["is_extended_storage_sizes_enabled"], false)
  is_performance_advisor_enabled                   = try(each.value["is_performance_advisor_enabled"], false)
  is_realtime_performance_panel_enabled            = try(each.value["is_realtime_performance_panel_enabled"], false)
  is_schema_advisor_enabled                        = try(each.value["is_schema_advisor_enabled"], false)
  with_default_alerts_settings                     = try(each.value["with_default_alerts_settings"], null)
}

resource "mongodbatlas_cluster" "cluster" {
  for_each = var.clusters

  project_id   = mongodbatlas_project.project[each.value.project].id
  name         = try(each.value["name"], each.key)
  cluster_type = each.value.cluster_type

  dynamic "replication_specs" {
    for_each = [each.value.replication_specs]
    content {
      num_shards = replication_specs.value.num_shards
      zone_name  = replication_specs.value["zone_name"]
      dynamic "regions_config" {
        for_each = [replication_specs.value.regions_config]
        content {
          analytics_nodes = regions_config.value["analytics_nodes"]
          electable_nodes = regions_config.value["electable_nodes"]
          priority        = regions_config.value["priority"]
          read_only_nodes = regions_config.value["read_only_nodes"]
          region_name     = regions_config.value["region_name"]
        }
      }
    }
  }

  cloud_backup                                    = try(each.value["cloud_backup"], true)
  pit_enabled                                     = try(each.value["pit_enabled"], false)
  auto_scaling_disk_gb_enabled                    = try(each.value["auto_scaling_disk_gb_enabled"], true)
  disk_size_gb                                    = try(each.value["disk_size_gb"], 20)
  auto_scaling_compute_enabled                    = try(each.value["auto_scaling_compute_enabled"], false)
  auto_scaling_compute_scale_down_enabled         = try(each.value["auto_scaling_compute_scale_down_enabled"], false)
  provider_auto_scaling_compute_max_instance_size = try(each.value["provider_auto_scaling_compute_max_instance_size"], null)
  provider_auto_scaling_compute_min_instance_size = try(each.value["provider_auto_scaling_compute_min_instance_size"], null)

  mongo_db_major_version = try(each.value["mongo_db_major_version"], "7.0")

  provider_name               = each.value.provider_name
  provider_instance_size_name = each.value.provider_instance_size_name

  lifecycle {
    ignore_changes = [
      provider_instance_size_name,
    ]
  }
}

resource "mongodbatlas_cloud_backup_schedule" "backup_schedule" {
  for_each = { for k, v in var.clusters : k => v if v.cloud_backup_schedule != null }

  project_id   = mongodbatlas_project.project[each.value.project].id
  cluster_name = each.key

  reference_hour_of_day    = each.value.cloud_backup_schedule.reference_hour_of_day
  reference_minute_of_hour = each.value.cloud_backup_schedule.reference_minute_of_hour
  restore_window_days      = each.value.cloud_backup_schedule.restore_window_days

  dynamic "copy_settings" {
    for_each = each.value.cloud_backup_schedule.copy_settings != null ? each.value.cloud_backup_schedule.copy_settings : []
    content {
      cloud_provider      = copy_settings.value.cloud_provider
      frequencies         = copy_settings.value.frequencies
      region_name         = copy_settings.value.region_name
      replication_spec_id = copy_settings.value.cloud_provider == "AWS" ? mongodbatlas_cluster.cluster[each.key].replication_specs.*.id[0] : null
      should_copy_oplogs  = copy_settings.value.should_copy_oplogs
    }
  }

  dynamic "policy_item_hourly" {
    for_each = try(each.value.cloud_backup_schedule.policy_item_hourly != null ? [each.value.cloud_backup_schedule.policy_item_hourly] : [])
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }

  dynamic "policy_item_daily" {
    for_each = try(each.value.cloud_backup_schedule.policy_item_daily != null ? [each.value.cloud_backup_schedule.policy_item_daily] : [])
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }

  dynamic "policy_item_weekly" {
    for_each = try(each.value.cloud_backup_schedule.policy_item_weekly != null ? [each.value.cloud_backup_schedule.policy_item_weekly] : [])
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }

  dynamic "policy_item_monthly" {
    for_each = try(each.value.cloud_backup_schedule.policy_item_monthly != null ? [each.value.cloud_backup_schedule.policy_item_monthly] : [])
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }

  dynamic "policy_item_yearly" {
    for_each = try(each.value.cloud_backup_schedule.policy_item_yearly != null ? [each.value.cloud_backup_schedule.policy_item_yearly] : [])
    content {
      frequency_interval = policy_item_yearly.value.frequency_interval
      retention_unit     = policy_item_yearly.value.retention_unit
      retention_value    = policy_item_yearly.value.retention_value
    }
  }
}

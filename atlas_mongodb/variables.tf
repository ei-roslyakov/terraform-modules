variable "org_id" {
  description = "The unique identifier of the organization in which the project should be created"
  type        = string
}

variable "teams" {
  description = "A map of teams to create in the organization"
  type        = map(any)
  default     = {}
}

variable "projects" {
  description = "A list of projects to create in MongoDB Atlas."
  type = map(object({
    name = string
    teams = map(object({
      role_names = list(string)
    }))
    limits = optional(map(object({
      name  = string
      value = number
    })), {})
    project_access = optional(map(object({
      username   = string
      role_names = list(string)
    })))
    ip_access_list = optional(list(object({
      ip_address = string
      comment    = string
    })))
    cidr_block_access_list = optional(list(object({
      cidr_block = string
      comment    = string
    })))
    aws_security_group_access_list = optional(list(object({
      aws_security_group = string
      comment            = string
    })))
    project_owner_id                                 = optional(string)
    is_collect_database_specifics_statistics_enabled = optional(bool)
    is_data_explorer_enabled                         = optional(bool)
    is_extended_storage_sizes_enabled                = optional(bool)
    is_performance_advisor_enabled                   = optional(bool)
    is_realtime_performance_panel_enabled            = optional(bool)
    is_schema_advisor_enabled                        = optional(bool)
    with_default_alerts_settings                     = optional(bool)
  }))
}

variable "clusters" {
  description = "A list of clusters to create in MongoDB Atlas."
  type = map(object({
    project                     = string
    provider_name               = string
    provider_instance_size_name = string
    cluster_type                = string
    replication_specs = object({
      num_shards = number
      zone_name  = string
      regions_config = object({
        analytics_nodes = number
        region_name     = string
        electable_nodes = number
        priority        = number
        read_only_nodes = number
      })
    })
    cloud_backup                                    = bool
    pit_enabled                                     = bool
    auto_scaling_disk_gb_enabled                    = bool
    disk_size_gb                                    = number
    auto_scaling_compute_enabled                    = optional(bool)
    auto_scaling_compute_scale_down_enabled         = optional(bool)
    provider_auto_scaling_compute_max_instance_size = optional(string)
    provider_auto_scaling_compute_min_instance_size = optional(string)
    mongo_db_major_version                          = string
    cloud_backup_schedule = optional(object({
      reference_hour_of_day    = optional(number)
      reference_minute_of_hour = optional(number)
      restore_window_days      = optional(number)
      copy_settings = optional(list(object({
        cloud_provider     = string
        frequencies        = list(string)
        region_name        = string
        should_copy_oplogs = bool
      })))
      policy_item_hourly = optional(object({
        frequency_interval = number
        retention_unit     = string
        retention_value    = number
      }))
      policy_item_daily = optional(object({
        frequency_interval = number
        retention_unit     = string
        retention_value    = number
      }))
      policy_item_weekly = optional(object({
        frequency_interval = number
        retention_unit     = string
        retention_value    = number
      }))
      policy_item_monthly = optional(object({
        frequency_interval = number
        retention_unit     = string
        retention_value    = number
      }))
      policy_item_yearly = optional(object({
        frequency_interval = number
        retention_unit     = string
        retention_value    = number
      }))
    }))
  }))
}

variable "database_users" {
  description = "A list of database users to create in MongoDB Atlas."
  type = map(object({
    project  = string
    username = string
    password = string
    roles = list(object({
      database_name = string
      role_name     = string
    }))
    labels = list(object({
      key   = string
      value = string
    }))
    scopes = list(object({
      name = string
      type = string
    }))
  }))
}


## Example

```hcl
inputs = {

  org_id = "12345678"


  teams = {
    management : {
      users : ["user@example.com"]
      role : "PROJECT_OWNER"
    }
  }

  projects = {
    "Quality Assurance" = {
      name = "Quality Assurance"
      teams = {
        management = {
          role_names = ["GROUP_OWNER"]
        }
      }
      project_access = {}
      ip_access_list = []
      cidr_block_access_list = [
        {
          cidr_block = "10.10.0.0/16"
          comment    = "vpc-qa"
        }
      ]
      aws_security_group_access_list = []
    }
  }

  clusters = {
    "QA" : {
      project : "Quality Assurance"
      provider_name : "AWS"
      provider_instance_size_name : "M20"

      cluster_type : "REPLICASET"
      replication_specs : {
        num_shards : 1
        zone_name : "Zone 1"
        regions_config : {
          analytics_nodes = 0
          electable_nodes = 3
          priority        = 7
          read_only_nodes = 0
          region_name     = "US_EAST_2"
        }
      }
      cloud_backup : true
      pit_enabled : true
      auto_scaling_compute_enabled                    = true
      provider_auto_scaling_compute_max_instance_size = "M40"
      provider_auto_scaling_compute_min_instance_size = "M20"
      auto_scaling_disk_gb_enabled : true
      disk_size_gb : 40
      mongo_db_major_version : "7.0"

      cloud_backup_schedule = {
        reference_hour_of_day = 23
        reference_minute_of_hour = 32
        restore_window_days = 2

        policy_item_hourly = {
          frequency_interval = 6
          retention_unit = "days"
          retention_value = 3
        }
        policy_item_daily = {
          frequency_interval = 1
          retention_unit = "days"
          retention_value = 7
        }
        policy_item_monthly = {
          frequency_interval = 40
          retention_unit = "months"
          retention_value = 12
        }
        // policy_item_weekly = {}
        // policy_item_yearly = {}
      }
      copy_settings = [{
          cloud_provider     = "AWS"
          frequencies        = ["DAILY", "HOURLY", "MONTHLY", "ON_DEMAND", "WEEKLY"]
          region_name        = "US_EAST_1"
          should_copy_oplogs = false
        }]
    },
    "QA-V7" : {
      project : "Quality Assurance"
      provider_name : "AWS"
      provider_instance_size_name : "M20"

      cluster_type : "REPLICASET"
      replication_specs : {
        num_shards : 1
        zone_name : "Zone 1"
        regions_config : {
          analytics_nodes = 0
          electable_nodes = 3
          priority        = 7
          read_only_nodes = 0
          region_name     = "US_EAST_2"
        }
      }
      cloud_backup : true
      pit_enabled : true
      auto_scaling_compute_enabled                    = true
      provider_auto_scaling_compute_max_instance_size = "M40"
      provider_auto_scaling_compute_min_instance_size = "M20"
      auto_scaling_disk_gb_enabled : true
      disk_size_gb : 40
      mongo_db_major_version : "7.0"

      cloud_backup_schedule = {
        reference_hour_of_day = 23
        reference_minute_of_hour = 32
        restore_window_days = 2

        policy_item_hourly = {
          frequency_interval = 6
          retention_unit = "days"
          retention_value = 3
        }
        policy_item_daily = {
          frequency_interval = 1
          retention_unit = "days"
          retention_value = 7
        }
        policy_item_monthly = {
          frequency_interval = 40
          retention_unit = "months"
          retention_value = 12
        }
        // policy_item_weekly = {}
        // policy_item_yearly = {}
      }
    }
  }

  database_users = {
    "eugene" = {
      project : "Quality Assurance"
      username : "eugene"
      password : "password"
      roles : [
        {
          database_name : "admin"
          role_name : "atlasAdmin"
        }
      ]
      labels : []
      scopes : [
        {
          name : "QA"
          type : "CLUSTER"
        },
        {
          name : "QA-V7"
          type : "CLUSTER"
        }
      ]
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | 1.17.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | 1.17.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mongodbatlas_cloud_backup_schedule.backup_schedule](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/cloud_backup_schedule) | resource |
| [mongodbatlas_cluster.cluster](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/cluster) | resource |
| [mongodbatlas_database_user.db_user](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/database_user) | resource |
| [mongodbatlas_project.project](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/project) | resource |
| [mongodbatlas_project_invitation.invitation](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/project_invitation) | resource |
| [mongodbatlas_project_ip_access_list.cidr_block](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/project_ip_access_list) | resource |
| [mongodbatlas_project_ip_access_list.ip_address](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/project_ip_access_list) | resource |
| [mongodbatlas_project_ip_access_list.sg](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/project_ip_access_list) | resource |
| [mongodbatlas_team.team](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.3/docs/resources/team) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusters"></a> [clusters](#input\_clusters) | A list of clusters to create in MongoDB Atlas. | <pre>map(object({<br>    project                     = string<br>    provider_name               = string<br>    provider_instance_size_name = string<br>    cluster_type                = string<br>    replication_specs = object({<br>      num_shards = number<br>      zone_name  = string<br>      regions_config = object({<br>        analytics_nodes = number<br>        region_name     = string<br>        electable_nodes = number<br>        priority        = number<br>        read_only_nodes = number<br>      })<br>    })<br>    cloud_backup                                    = bool<br>    pit_enabled                                     = bool<br>    auto_scaling_disk_gb_enabled                    = bool<br>    disk_size_gb                                    = number<br>    auto_scaling_compute_enabled                    = optional(bool)<br>    auto_scaling_compute_scale_down_enabled         = optional(bool)<br>    provider_auto_scaling_compute_max_instance_size = optional(string)<br>    provider_auto_scaling_compute_min_instance_size = optional(string)<br>    mongo_db_major_version                          = string<br>    cloud_backup_schedule = optional(object({<br>      reference_hour_of_day    = optional(number)<br>      reference_minute_of_hour = optional(number)<br>      restore_window_days      = optional(number)<br>      copy_settings = optional(list(object({<br>        cloud_provider     = string<br>        frequencies        = list(string)<br>        region_name        = string<br>        should_copy_oplogs = bool<br>      })))<br>      policy_item_hourly = optional(object({<br>        frequency_interval = number<br>        retention_unit     = string<br>        retention_value    = number<br>      }))<br>      policy_item_daily = optional(object({<br>        frequency_interval = number<br>        retention_unit     = string<br>        retention_value    = number<br>      }))<br>      policy_item_weekly = optional(object({<br>        frequency_interval = number<br>        retention_unit     = string<br>        retention_value    = number<br>      }))<br>      policy_item_monthly = optional(object({<br>        frequency_interval = number<br>        retention_unit     = string<br>        retention_value    = number<br>      }))<br>      policy_item_yearly = optional(object({<br>        frequency_interval = number<br>        retention_unit     = string<br>        retention_value    = number<br>      }))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_database_users"></a> [database\_users](#input\_database\_users) | A list of database users to create in MongoDB Atlas. | <pre>map(object({<br>    project  = string<br>    username = string<br>    password = string<br>    roles = list(object({<br>      database_name = string<br>      role_name     = string<br>    }))<br>    labels = list(object({<br>      key   = string<br>      value = string<br>    }))<br>    scopes = list(object({<br>      name = string<br>      type = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The unique identifier of the organization in which the project should be created | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input\_projects) | A list of projects to create in MongoDB Atlas. | <pre>map(object({<br>    name = string<br>    teams = map(object({<br>      role_names = list(string)<br>    }))<br>    limits = optional(map(object({<br>      name  = string<br>      value = number<br>    })), {})<br>    project_access = optional(map(object({<br>      username   = string<br>      role_names = list(string)<br>    })))<br>    ip_access_list = optional(list(object({<br>      ip_address = string<br>      comment    = string<br>    })))<br>    cidr_block_access_list = optional(list(object({<br>      cidr_block = string<br>      comment    = string<br>    })))<br>    aws_security_group_access_list = optional(list(object({<br>      aws_security_group = string<br>      comment            = string<br>    })))<br>    project_owner_id                                 = optional(string)<br>    is_collect_database_specifics_statistics_enabled = optional(bool)<br>    is_data_explorer_enabled                         = optional(bool)<br>    is_extended_storage_sizes_enabled                = optional(bool)<br>    is_performance_advisor_enabled                   = optional(bool)<br>    is_realtime_performance_panel_enabled            = optional(bool)<br>    is_schema_advisor_enabled                        = optional(bool)<br>    with_default_alerts_settings                     = optional(bool)<br>  }))</pre> | n/a | yes |
| <a name="input_teams"></a> [teams](#input\_teams) | A map of teams to create in the organization | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mongodbatlas_cluster_connection_strings"></a> [mongodbatlas\_cluster\_connection\_strings](#output\_mongodbatlas\_cluster\_connection\_strings) | IDs of the MongoDB Atlas clusters. |
| <a name="output_mongodbatlas_cluster_ids"></a> [mongodbatlas\_cluster\_ids](#output\_mongodbatlas\_cluster\_ids) | IDs of the MongoDB Atlas clusters. |
| <a name="output_mongodbatlas_cluster_mongo_uri"></a> [mongodbatlas\_cluster\_mongo\_uri](#output\_mongodbatlas\_cluster\_mongo\_uri) | IDs of the MongoDB Atlas clusters. |
| <a name="output_mongodbatlas_cluster_snapshot_backup_policy"></a> [mongodbatlas\_cluster\_snapshot\_backup\_policy](#output\_mongodbatlas\_cluster\_snapshot\_backup\_policy) | IDs of the MongoDB Atlas clusters. |
| <a name="output_mongodbatlas_cluster_srv_address"></a> [mongodbatlas\_cluster\_srv\_address](#output\_mongodbatlas\_cluster\_srv\_address) | IDs of the MongoDB Atlas clusters. |
| <a name="output_mongodbatlas_project_ids"></a> [mongodbatlas\_project\_ids](#output\_mongodbatlas\_project\_ids) | IDs of the MongoDB Atlas projects. |
| <a name="output_mongodbatlas_team_ids"></a> [mongodbatlas\_team\_ids](#output\_mongodbatlas\_team\_ids) | IDs of the MongoDB Atlas teams. |
<!-- END_TF_DOCS -->

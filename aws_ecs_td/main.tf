locals {
  ecs_task_execution_role_custom_policies = var.execution_role_arn == "" && length(var.ecs_task_execution_role_custom_policies) > 1 ? var.ecs_task_execution_role_custom_policies : []
  partition                               = data.aws_partition.current.partition
}

resource "aws_iam_role" "ecs_task_execution_role" {
  count = var.execution_role_arn == "" ? 1 : 0

  name = "${var.family}-ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  count = var.execution_role_arn == "" ? 1 : 0

  role       = join("", aws_iam_role.ecs_task_execution_role.*.name)
  policy_arn = "arn:${local.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_custom_policy" {
  for_each = toset(local.ecs_task_execution_role_custom_policies)

  role       = join("", aws_iam_role.ecs_task_execution_role.*.name)
  policy_arn = each.key
}

resource "aws_ecs_task_definition" "td" {
  family = var.family

  container_definitions = file(var.container_definitions)

  network_mode = var.network_mode

  #FARGATE
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  requires_compatibilities = var.requires_compatibilities

  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn == "" ? join("", aws_iam_role.ecs_task_execution_role.*.arn) : var.execution_role_arn

  dynamic "volume" {
    for_each = var.volumes
    content {
      name = volume.value.name

      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)
          dynamic "authorization_config" {
            for_each = lookup(efs_volume_configuration.value, "authorization_config", [])
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }

}
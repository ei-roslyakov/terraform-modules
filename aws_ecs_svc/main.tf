locals {
  ecs_service_launch_type  = var.ecs_use_fargate ? "FARGATE" : "EC2"
  fargate_platform_version = var.ecs_use_fargate ? var.fargate_platform_version : null

  ecs_service_ordered_placement_strategy = {
    EC2 = [
      {
        type  = "spread"
        field = "attribute:ecs.availability-zone"
      },
      {
        type  = "spread"
        field = "instanceId"
      },
    ]
    FARGATE = []
  }

  ecs_service_placement_constraints = {
    EC2 = [
      {
        type = "distinctInstance"
      },
    ]
    FARGATE = []
  }
}

resource "aws_ecs_service" "main" {
  name    = var.name
  cluster = var.cluster

  launch_type            = local.ecs_service_launch_type
  platform_version       = local.fargate_platform_version
  enable_execute_command = var.enable_execute_command

  task_definition = var.task_definition

  desired_count                      = var.tasks_desired_count
  deployment_minimum_healthy_percent = var.tasks_minimum_healthy_percent
  deployment_maximum_percent         = var.tasks_maximum_percent

  dynamic "ordered_placement_strategy" {
    for_each = local.ecs_service_ordered_placement_strategy[local.ecs_service_launch_type]

    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  dynamic "placement_constraints" {
    for_each = local.ecs_service_placement_constraints[local.ecs_service_launch_type]

    content {
      type = placement_constraints.value.type
    }
  }

  network_configuration {
    subnets          = var.ecs_subnet_ids
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.associate_alb || var.associate_nlb ? var.lb_target_groups : []
    content {
      container_name   = load_balancer.value.container_name
      target_group_arn = load_balancer.value.lb_target_group_arn
      container_port   = load_balancer.value.container_port
    }
  }

  health_check_grace_period_seconds = var.associate_alb || var.associate_nlb ? var.health_check_grace_period_seconds : null


  enable_ecs_managed_tags = var.enable_ecs_managed_tags



  lifecycle {
    ignore_changes = [task_definition]
  }
}
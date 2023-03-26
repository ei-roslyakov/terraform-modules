## Usage

```hcl
inputs = {
  name             = "my-svc"
  
  ecs_use_fargate = true
  task_definition = ""

  desired_count                       = 1
  deployment_minimum_healthy_percent  = 100
  deployment_maximum_percent          = 200

  tags = {
    Environment = local.env.env
  }


}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_security_group"></a> [alb\_security\_group](#input\_alb\_security\_group) | Application Load Balancer (ALB) security group ID to allow traffic from. | `string` | `""` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false. | `bool` | `false` | no |
| <a name="input_associate_alb"></a> [associate\_alb](#input\_associate\_alb) | Whether to associate an Application Load Balancer (ALB) with the ECS service. | `bool` | `false` | no |
| <a name="input_associate_nlb"></a> [associate\_nlb](#input\_associate\_nlb) | Whether to associate a Network Load Balancer (NLB) with the ECS service. | `bool` | `false` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | ARN of an ECS cluster. | `string` | `""` | no |
| <a name="input_ecs_subnet_ids"></a> [ecs\_subnet\_ids](#input\_ecs\_subnet\_ids) | Subnets associated with the task or service. | `list(string)` | `[]` | no |
| <a name="input_ecs_use_fargate"></a> [ecs\_use\_fargate](#input\_ecs\_use\_fargate) | Whether to use Fargate for the task definition. | `bool` | `false` | no |
| <a name="input_enable_ecs_managed_tags"></a> [enable\_ecs\_managed\_tags](#input\_enable\_ecs\_managed\_tags) | Specifies whether to enable Amazon ECS managed tags for the tasks within the service. | `bool` | `false` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | (Optional) Specifies whether to enable Amazon ECS Exec for the tasks within the service. | `bool` | `false` | no |
| <a name="input_fargate_platform_version"></a> [fargate\_platform\_version](#input\_fargate\_platform\_version) | The platform version on which to run your service. Only applicable when using Fargate launch type. | `string` | `"LATEST"` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers. | `number` | `null` | no |
| <a name="input_lb_target_groups"></a> [lb\_target\_groups](#input\_lb\_target\_groups) | List of load balancer target group objects containing the lb\_target\_group\_arn, container\_port and container\_health\_check\_port. The container\_port is the port on which the container will receive traffic. The container\_health\_check\_port is an additional port on which the container can receive a health check. The lb\_target\_group\_arn is either Application Load Balancer (ALB) or Network Load Balancer (NLB) target group ARN tasks will register with. | <pre>list(<br>    object({<br>      container_name   = string<br>      container_port   = number<br>      target_group_arn = string<br>      }<br>    )<br>  )</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the service (up to 255 letters, numbers, hyphens, and underscores) | `string` | `""` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |
| <a name="input_task_definition"></a> [task\_definition](#input\_task\_definition) | Family and revision (family:revision) or full ARN of the task definition that you want to run in your service. Required unless using the EXTERNAL deployment controller. If a revision is not specified, the latest ACTIVE revision is used. | `string` | `""` | no |
| <a name="input_tasks_desired_count"></a> [tasks\_desired\_count](#input\_tasks\_desired\_count) | The number of instances of a task definition. | `number` | `1` | no |
| <a name="input_tasks_maximum_percent"></a> [tasks\_maximum\_percent](#input\_tasks\_maximum\_percent) | Upper limit on the number of running tasks. | `number` | `200` | no |
| <a name="input_tasks_minimum_healthy_percent"></a> [tasks\_minimum\_healthy\_percent](#input\_tasks\_minimum\_healthy\_percent) | Lower limit on the number of running tasks. | `number` | `100` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service_id"></a> [ecs\_service\_id](#output\_ecs\_service\_id) | ARN of the ECS service. |
<!-- END_TF_DOCS -->
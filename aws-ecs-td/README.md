## Usage

```hcl
inputs = {
  family            = "my-task"
  
  task_cpu          = 256
  task_memory       = 256

  network_mode      = "awsvpc"

  requires_compatibilities  = ["FARGATE"]
  container_definitions     = "./task-definition.json"


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
| [aws_ecs_task_definition.td](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_custom_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | Valid container definitions provided as a single valid JSON document. | `string` | `""` | no |
| <a name="input_ecs_task_execution_role_custom_policies"></a> [ecs\_task\_execution\_role\_custom\_policies](#input\_ecs\_task\_execution\_role\_custom\_policies) | (Optional) Custom policies to attach to the ECS task execution role. For example for reading secrets from AWS Systems Manager Parameter Store or Secrets Manager | `list(string)` | `[]` | no |
| <a name="input_ecs_use_fargate"></a> [ecs\_use\_fargate](#input\_ecs\_use\_fargate) | Whether to use Fargate for the task definition. | `bool` | `false` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | (Optional) ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. | `string` | `""` | no |
| <a name="input_family"></a> [family](#input\_family) | (Required) A unique name for your task definition. | `string` | n/a | yes |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The Docker networking mode to use for the containers in the task | `string` | `"bridge"` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | Set of launch types required by the task. The valid values are EC2 and FARGATE. | `list(string)` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The number of cpu units limited for the task. Required for Fargate. _null_ to disable | `number` | `null` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | Memory (in MiB) for the task. Required for Fargate. _null_ to disable | `number` | `null` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The short name or full Amazon Resource Name (ARN) of the IAM role that containers in this task can assume | `string` | `""` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A list of volume definitions in JSON format that containers in your task may use | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ecs_task_definition_td_arn"></a> [aws\_ecs\_task\_definition\_td\_arn](#output\_aws\_ecs\_task\_definition\_td\_arn) | Full ARN of the Task Definition (including both family and revision). |
| <a name="output_aws_iam_role_ecs_task_execution_role_arn"></a> [aws\_iam\_role\_ecs\_task\_execution\_role\_arn](#output\_aws\_iam\_role\_ecs\_task\_execution\_role\_arn) | The Amazon Resource Name (ARN) specifying the role. |
<!-- END_TF_DOCS -->
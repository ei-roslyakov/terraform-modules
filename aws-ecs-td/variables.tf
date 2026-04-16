variable "ecs_use_fargate" {
  description = "Whether to use Fargate for the task definition."
  default     = false
  type        = bool
}

variable "volumes" {
  default     = []
  description = "A list of volume definitions in JSON format that containers in your task may use"
  type        = list(any)
}

variable "task_cpu" {
  default     = null
  description = "The number of cpu units limited for the task. Required for Fargate. _null_ to disable"
  type        = number
}

variable "task_memory" {
  default     = null
  description = "Memory (in MiB) for the task. Required for Fargate. _null_ to disable"
  type        = number
}

variable "network_mode" {
  default     = "bridge"
  description = "The Docker networking mode to use for the containers in the task"
  type        = string
}

variable "family" {
  description = "(Required) A unique name for your task definition."
  type        = string
}

variable "container_definitions" {
  description = "Valid container definitions provided as a single valid JSON document."
  type        = string
  default     = ""
}

variable "requires_compatibilities" {
  default     = ["FARGATE"]
  description = "Set of launch types required by the task. The valid values are EC2 and FARGATE."
  type        = list(string)
}

variable "task_role_arn" {
  default     = ""
  type        = string
  description = "The short name or full Amazon Resource Name (ARN) of the IAM role that containers in this task can assume"
}

variable "execution_role_arn" {
  default     = ""
  type        = string
  description = "(Optional) ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
}

variable "ecs_task_execution_role_custom_policies" {
  description = "(Optional) Custom policies to attach to the ECS task execution role. For example for reading secrets from AWS Systems Manager Parameter Store or Secrets Manager"
  type        = list(string)
  default     = []
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags`"
}

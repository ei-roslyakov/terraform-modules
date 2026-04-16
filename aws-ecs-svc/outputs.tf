output "ecs_service_id" {
  description = "ARN of the ECS service."
  value       = aws_ecs_service.main.id
}
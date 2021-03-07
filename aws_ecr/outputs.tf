output "ecr_repository_url_map" {
  value = zipmap(
    values(aws_ecr_repository.ecr_repo)[*].name,
    values(aws_ecr_repository.ecr_repo)[*].repository_url
  )
  description = "Map of repository names to repository URLs"
}
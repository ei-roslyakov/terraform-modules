output "repository_url_map" {
  value = zipmap(
    values(aws_ecr_repository.repo)[*].name,
    values(aws_ecr_repository.repo)[*].repository_url
  )
  description = "Map of repository names to repository URLs"
}
output "repository_arn_map" {
  value = zipmap(
    values(aws_ecr_repository.repo)[*].name,
    values(aws_ecr_repository.repo)[*].arn
  )
  description = "Map of repository names to repository ARNs"
}
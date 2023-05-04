output "ecr_repositories" {
  description = "The name of the IAM role created"
  value = {
    for repo in aws_ecr_repository.ecr_repo : repo.name => repo.repository_url
  }
}
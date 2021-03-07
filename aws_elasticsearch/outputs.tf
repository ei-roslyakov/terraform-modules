output "security_group_id" {
  value       = join("", aws_security_group.es_security_group.*.id)
  description = "Security Group ID to control access to the Elasticsearch domain"
}

output "domain_arn" {
  value       = join("", aws_elasticsearch_domain.es.*.arn)
  description = "ARN of the Elasticsearch domain"
}

output "domain_id" {
  value       = join("", aws_elasticsearch_domain.es.*.domain_id)
  description = "Unique identifier for the Elasticsearch domain"
}

output "domain_name" {
  value       = join("", aws_elasticsearch_domain.es.*.domain_name)
  description = "Name of the Elasticsearch domain"
}

output "endpoint_address" {
  value       = join("", aws_elasticsearch_domain.es.*.endpoint)
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
}

output "kibana_endpoint" {
  value       = join("", aws_elasticsearch_domain.es.*.kibana_endpoint)
  description = "Domain-specific endpoint for Kibana without https scheme"
}
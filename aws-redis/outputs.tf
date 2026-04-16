output "member_clusters" {
  description = "Cache clusters"
  value       = aws_elasticache_replication_group.redis_replication_group.*.member_clusters
}

output "endpoint_address" {
  value       = join("", aws_elasticache_replication_group.redis_replication_group.*.primary_endpoint_address)
  description = "Redis primary endpoint"
}
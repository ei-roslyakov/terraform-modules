output "arn" {
  value       = join("", aws_rds_cluster.this.*.arn)
  description = "Amazon Resource Name (ARN) of the cluster"
}
output "cluster_identifier" {
  value       = join("", aws_rds_cluster.this.*.cluster_identifier)
  description = "Cluster Identifier"
}
output "endpoint" {
  value       = join("", aws_rds_cluster.this.*.endpoint)
  description = "The DNS address of the RDS instance"
}
output "reader_endpoint" {
  value       = join("", aws_rds_cluster.this.*.reader_endpoint)
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas"
}
output "security_group_id" {
  value       = join("", aws_security_group.default.*.id)
  description = "Security Group ID"
}

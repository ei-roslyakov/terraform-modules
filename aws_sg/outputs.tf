output "id" {
  value       = join("", aws_security_group.this.*.id)
  description = "IDs on the AWS Security Groups associated with the instance."
}

output "name" {
  description = "The name of the security group"
  value       = join("", aws_security_group.this.*.name)
}

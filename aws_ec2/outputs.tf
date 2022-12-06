output "private_ip" {
  description = "Private IP of instance"
  value       = join("", aws_instance.default.*.private_ip)
}
output "private_dns" {
  description = "Private DNS of instance"
  value       = join("", aws_instance.default.*.private_dns)
}
output "id" {
  description = "Disambiguated ID of the instance"
  value       = join("", aws_instance.default.*.id)
}
output "ssh_key_pair" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = var.ssh_key_pair
}
output "role" {
  description = "Name of AWS IAM Role associated with the instance"
  value       = join("", aws_iam_role.default.*.name)
}
output "public_ip" {
  description = "Public IP of instance"
  value       = join("", aws_instance.default.*.public_ip)
}
output "public_dns" {
  description = "Public DNS of instance"
  value       = join("", aws_instance.default.*.public_dns)
}
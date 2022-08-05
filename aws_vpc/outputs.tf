output "vpc_id" {
  description = "The the VPC id"
  value       = concat(aws_vpc.this.*.id, [""])[0]
}
output "vpc_arn" {
  description = "VPC ARN"
  value       = concat(aws_vpc.this.*.arn, [""])[0]
}
output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value      = concat(aws_vpc.this.*.cidr_block, [""])[0]
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}
output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private.*.arn
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}
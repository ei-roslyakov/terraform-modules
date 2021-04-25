locals {
  vpc_id            = element(concat(aws_vpc.this.*.id, ), 0)
  max_subnet_length = max(length(var.private_subnets), )
  nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(var.azs) : local.max_subnet_length
  nat_gateway_ips   = split(",", join(",", aws_eip.nat.*.id))
}
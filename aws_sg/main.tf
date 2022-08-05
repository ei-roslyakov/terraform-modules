locals {
  security_group_count           = var.enable_security_group == true ? 1 : 0
  enable_cidr_rules              = var.enable_security_group && (length(var.allowed_ip) > 0)
  enable_source_sec_group_rules  = var.enable_security_group && (length(var.security_groups) > 0)
  ports_source_sec_group_product = setproduct(compact(var.allowed_ports_sg), compact(var.security_groups))
}

resource "random_string" "prefix" {
  length  = 4
  upper   = false
  special = false
}

resource "aws_security_group" "this" {
  count = local.security_group_count

  name        = var.name_pefix == true ? "${var.name}-${random_string.prefix.result}" : var.name
  vpc_id      = var.vpc_id
  description = var.description
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress" {
  count = var.enable_security_group == true ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.this.*.id)
}

resource "aws_security_group_rule" "ingress_cidr" {
  count = local.enable_cidr_rules == true ? length(compact(var.allowed_ports_cidr)) : 0

  type              = "ingress"
  from_port         = element(var.allowed_ports_cidr, count.index)
  to_port           = element(var.allowed_ports_cidr, count.index)
  protocol          = var.protocol
  cidr_blocks       = var.allowed_ip
  security_group_id = join("", aws_security_group.this.*.id)
}

resource "aws_security_group_rule" "custom_ingress_rule_cidr" {
  for_each = var.custom_ingress_rule_cidr

  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = var.protocol
  cidr_blocks       = each.value
  security_group_id = join("", aws_security_group.this.*.id)
}

resource "aws_security_group_rule" "ingress_sg" {
  count = local.enable_source_sec_group_rules == true ? length(local.ports_source_sec_group_product) : 0

  type                     = "ingress"
  from_port                = element(element(local.ports_source_sec_group_product, count.index), 0)
  to_port                  = element(element(local.ports_source_sec_group_product, count.index), 0)
  protocol                 = var.protocol
  source_security_group_id = element(element(local.ports_source_sec_group_product, count.index), 1)
  security_group_id        = join("", aws_security_group.this.*.id)
}
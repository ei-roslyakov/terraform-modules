resource "aws_security_group" "default" {
  count       = var.create_cluster ? 1 : 0
  name        = "${var.cluster_identifier}-sg"
  description = "Allow inbound traffic from Security Groups and CIDRs"
  vpc_id      = var.vpc_id
  tags = merge(
    {
      "Name" = format("%s-%s", var.cluster_identifier, "sg")
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count                    = var.create_cluster ? length(var.security_groups) : 0
  description              = "Allow inbound traffic from existing security groups"
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = var.security_groups[count.index]
  security_group_id        = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  count             = var.create_cluster && length(var.allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from existing CIDR blocks"
  type              = "ingress"
  from_port         = var.db_port
  to_port           = var.db_port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "egress" {
  count             = var.create_cluster ? 1 : 0
  description       = "Allow outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}


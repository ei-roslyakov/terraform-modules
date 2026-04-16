resource "aws_security_group" "es_security_group" {
  count       = var.create_elasticsearch ? 1 : 0
  name        = "${var.es_domain_name}-elasticsearch-sg"
  description = "Allow inbound traffic from the security groups"
  vpc_id      = var.vpc_id
  tags = merge(
    {
      "Name" = format("%s-%s", var.es_domain_name, "sg")
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count                    = var.create_elasticsearch ? 1 : 0
  description              = "Allow inbound traffic from EKS workers"
  type                     = "ingress"
  from_port                = var.elasticsearch_port
  to_port                  = var.elasticsearch_port
  protocol                 = "tcp"
  source_security_group_id = var.source_security_groups
  security_group_id        = join("", aws_security_group.es_security_group.*.id)
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  count             = var.create_elasticsearch && length(var.allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from existing CIDR blocks"
  type              = "ingress"
  from_port         = var.elasticsearch_port
  to_port           = var.elasticsearch_port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = join("", aws_security_group.es_security_group.*.id)
}

resource "aws_security_group_rule" "egress" {
  count             = var.create_elasticsearch ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.es_security_group.*.id)
}

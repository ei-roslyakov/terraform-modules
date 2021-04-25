resource "aws_security_group" "default" {
  count       = var.create_default_security_group ? 1 : 0
  name        = "${var.name}-ec2-sg"
  vpc_id      = var.vpc_id
  description = "Instance default security group (only egress access is allowed)"
  tags        = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress" {
  count             = var.create_default_security_group ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default[0].id
}

resource "aws_security_group_rule" "ingress" {
  count                    = var.create_default_security_group ? 1 : 0
  type                     = "ingress"
  from_port                = var.allowed_ports[count.index]
  to_port                  = var.allowed_ports[count.index]
  protocol                 = "tcp"
  source_security_group_id = var.defaulf_sg_source_security_group_id
  security_group_id        = aws_security_group.default[0].id
}
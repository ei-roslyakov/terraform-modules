resource "aws_security_group_rule" "ingress_security_groups" {
  count                    = var.create_elasticache ? 1 : 0
  description              = "Allow inbound traffic from existing Security Groups"
  type                     = "ingress"
  from_port                = var.elasticache_redis_port
  to_port                  = var.elasticache_redis_port
  protocol                 = "tcp"
  source_security_group_id = var.source_security_groups
  security_group_id        = join("", aws_security_group.redis-sg.*.id)
}

resource "aws_security_group_rule" "jenkins_acces" {
  count             = var.jenkins_acces ? 1 : 0
  description       = "Allow inbound traffic from existing Security Groups"
  type              = "ingress"
  from_port         = var.elasticache_redis_port
  to_port           = var.elasticache_redis_port
  protocol          = "tcp"
  cidr_blocks       = [var.jenkins_cidr]
  security_group_id = join("", aws_security_group.redis-sg.*.id)
}

resource "aws_security_group_rule" "egress" {
  count             = var.create_elasticache ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.redis-sg.*.id)
}

resource "aws_security_group" "redis-sg" {
  count       = var.create_elasticache ? 1 : 0
  name        = format("%s-%s", var.elasticache_clustes_name, "elasticache-sg")
  description = "Allow inbound traffic from the security groups"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s-%s", var.elasticache_clustes_name, "elasticache-sg")
    },
    var.tags,
  )
}
resource "aws_security_group" "instance_sg" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = "${var.name}-sg" })
}

resource "aws_security_group_rule" "instance_ingress" {
  for_each          = var.ingress
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.instance_sg.id
}

resource "aws_security_group_rule" "instance_egress" {
  for_each          = var.egress
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.instance_sg.id
}
module "ec2_security_group" {
  source  = "../security-group"
  name    = var.name
  tags    = merge(var.tags, { Name = "${var.name}-sg" })
  vpc_id  = var.vpc_id
  ingress = var.ingress
}
module "ec2" {
  source                      = "./modules/ec2"
  name                        = "demo"
  availability_zone           = element(local.availability_zones, 1)
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_id                      = local.vpc_id
  subnet_id                   = element(local.public_subnet_ids, 0)
  volume_size                 = 50
  iam_instance_profile        = "demo"
  ami_id                      = local.ami_id
  ebs_volume_size             = 50
  ebs_volume_type             = "gp2"
  tags = merge(
    local.common_tags,
    {
      Name           = var.name
      classification = "Level 2 - Confidential",
    }
  )
  ingress = {
    "22" = {
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = [local.vpc_cidr_blocks]
    },
    "8080" = {
      protocol    = "tcp"
      from_port   = 8080
      to_port     = 8080
      cidr_blocks = [local.vpc_cidr_blocks]
    }
  }
}
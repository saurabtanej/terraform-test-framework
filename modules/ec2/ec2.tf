resource "aws_instance" "demo" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [module.ec2_security_group.security_group_id]
  subnet_id                   = var.subnet_id
  availability_zone           = var.availability_zone
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data
  key_name                    = var.key_name

  root_block_device {
    volume_size = var.volume_size
    tags        = merge(var.tags, { Name = var.name })
  }
  ebs_block_device {
    volume_size = 60
    device_name = "/dev/sdf"
    volume_type = var.ebs_volume_type
    tags        = merge(var.tags, { Name = var.name })
  }
  tags = merge(var.tags, { Name = var.name })
  lifecycle {
    ignore_changes = [ami]
  }
}
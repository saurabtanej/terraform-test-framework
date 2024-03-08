data "aws_caller_identity" "current" {}

data "aws_availability_zones" "zones" {
  state = "available"
}

data "aws_region" "this" {
  provider = aws
}


data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # Ubuntu AMI
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"] # Filter by Amazon as the owner
}

data "aws_vpc" "selected" {
  id = local.vpc_id
}
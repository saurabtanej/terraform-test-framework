locals {
  availability_zones = data.aws_availability_zones.zones.names
  environment        = "development"
  common_tags = {
    Organization = "Velotio"
    Environment  = local.environment
  }
  name              = "demo"
  ami_id            = data.aws_ami.amazon_linux.id
  vpc_cidr_blocks   = data.aws_vpc.selected.cidr_block
  vpc_id            = "vpc-0d91cca8a524e7956"
  public_subnet_ids = ["subnet-08995352fb66b9ca0", "subnet-0fcfaa0cfff9b7a68", "subnet-0d87d750193492271"]
}

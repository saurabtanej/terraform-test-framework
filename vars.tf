variable "region_name" {
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "name" {}
variable "name" {
  type        = string
  description = "Name to be used for the resources"

  validation {
    condition     = length(var.name) >= 3
    error_message = "Name must be at least 3 characters long."
  }
}

variable "ami_id" {
  type        = string
  description = "AMI id for the instance"

  validation {
    condition     = can(regex("^ami-", var.ami_id))
    error_message = "AMI ID must start with 'ami-'."
  }
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC"

  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "VPC ID must start with 'vpc-'."
  }
}

variable "subnet_id" {
  type        = string
  description = "Id of the subnet to launch the instance"

  validation {
    condition     = can(regex("^subnet-", var.subnet_id))
    error_message = "Subnet ID must start with 'subnet-'."
  }
}

variable "availability_zone" {
  type        = string
  description = "The availability zone to launch the instance"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Specifies whether to create a public IP address for the instance"
}

variable "instance_type" {
  type        = string
  description = "Type of the instance"

  validation {
    # check if the value contains a dot
    condition     = can(regex("\\.", var.instance_type))
    error_message = "The name value must have at dot '.' in it."
  }
}

variable "iam_instance_profile" {
  type        = string
  description = "The IAM instance profile for the instance"
}

variable "volume_size" {
  type        = number
  description = "The size of the volume for the instance (Unit: GB)"
}

variable "user_data" {
  type        = string
  description = "User data to provide when launching the instance."
  default     = "null"
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
  default     = "devops"
}

variable "ingress" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "A map consisting of mapping for ingress security group rules"
}

variable "egress" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "A map consisting of mapping for egress security group rules"
  default = {
    "0" = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags for the resources"
}

variable "ebs_volume_size" {
  type        = number
  description = "Size of the ebs volume"
}

variable "ebs_volume_type" {
  type        = string
  description = "Type of the ebs volume"
  default     = "gp2"
}
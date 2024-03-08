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

variable "vpc_id" {
  type        = string
  description = "Id of the VPC"
}

variable "name" {
  type        = string
  description = "Name to be used for the resources"
}
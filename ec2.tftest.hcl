provider "aws" {
  region = "eu-west-1"
}

# Gloval Variables
variables {
  name = "demo"
  region_name = "eu-west-1"
  ami_id = "ami-xxxxx"
  instance_type = "t2.micro"
  subnet_id = "subnet-08995352fb66b9ca0"
  availability_zone = "eu-west-1a"
  associate_public_ip_address = true
  iam_instance_profile = "demo"
  volume_size = 50
  ebs_volume_size = 50
  ebs_volume_type = "gp2"
  vpc_id = "vpc-0d91cca8a524e7956"
  key_name = "demo_key"
  tags = {
      Name           = "demo",
      classification = "Level 2 - Confidential",
      Organization = "Velotio",
      Environment  = "development"
    }
  ingress = {
    "22" = {
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["10.1.0.0/16"]
    },
    "8080" = {
      protocol    = "tcp"
      from_port   = 8080
      to_port     = 8080
      cidr_blocks = ["10.1.0.0/16"]
    }
  }
}

#1 Run Data resources required for tests
run "setup_data" {

  module {
    source = "./tests/setup/data"
  }
}


#2 Validate Inputs
# run "validate_inputs"{
#   command = plan

#   variables {
#     instance_type = "t2micro"
#     name = "a"
#     ami_id = "does-not-exist"
#   }

#   expect_failures = [
#     var.instance_type,
#     var.name,
#     var.ami_id,
#   ]
# }

# #2 Unit test 
# run "name_and_tags_validation" {
#   command = plan
#   assert {
#     condition     = aws_instance.demo.tags_all["Name"] == var.name
#     error_message = "Error: Instance name is not as expected"
#   }
#   assert {
#     condition     = aws_instance.demo.tags_all["Organization"] == var.tags["Organization"]
#     error_message = "Error: Instance tags is not as expected"
#   }
#   assert {
#     condition     = aws_instance.demo.tags_all["Environment"] == var.tags["Environment"]
#     error_message = "Error: Instance tags is not as expected"
#   }
# }

# #3 Unit test 
# run "instance_type_validation" {
#   command = plan
#   assert {
#     condition     = aws_instance.demo.instance_type == var.instance_type
#     error_message = "Error: Instance type is not as expected"
#   }
# }

# #4 Unit Test with apply
# run "ebs_volume_validation" {
#   command = plan

#   assert {
#     condition     = length(aws_instance.demo.ebs_block_device) > 0
#     error_message = "Error: No EBS volumes attached to the instance."
#   }

#   assert {
#     condition = can([for device in aws_instance.demo.ebs_block_device : device.volume_size if device.volume_size == var.ebs_volume_size])
#     error_message = "Error: EBS volume size does not match expected value."
#   }

#   assert {
#     condition = can([for device in aws_instance.demo.ebs_block_device : device.volume_type if device.volume_type == var.ebs_volume_type])
#     error_message = "Error: EBS volume type does not match expected value."
#   }
# }


#2 modules - Integaration testing 
run "create_key_pair" {
  # Create the ec2 key pair .
  command = apply

  variables {
    keypair_name = "demo_key"
  }

  module {
    source = "./tests/setup/keypair-create"
  }
}

#3 modules - Integration testing
run "lookup_verify_key_pair" {
  # Verify created ec2 key pair.

  variables {
    keypair_name = "demo_key"
  }

  module {
    source = "./tests/setup/keypair-lookup"
  }

  assert {
    condition     = data.aws_key_pair.this.key_name == var.keypair_name
    error_message = "Key pair name is wrong"
  }
}

run "validate_key_pair" {
  variables {
    key_name = "${run.create_key_pair.key_name}"
    ami_id = "ami-0d940f23d527c3ab1"
  }
  assert {
    condition     = module.ec2.key_name == var.key_name
    error_message = "Key pair name is wrong"
  }
}

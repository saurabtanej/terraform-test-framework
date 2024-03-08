output "instance_id" {
  value = aws_instance.demo.id
}

output "ec2_instance_details" {
  value = [
    aws_instance.demo.arn,
    aws_instance.demo.instance_type,
    aws_instance.demo.private_ip,
    aws_instance.demo.security_groups
  ]
}
output "ec2_instance_tags" {
  value = aws_instance.demo.tags_all
}

output "ami_id" {
  value = aws_instance.demo.ami
}

output "key_id" {
  value = aws_instance.demo.key_name
}

output "iam_instance_profile" {
  value = aws_instance.demo.iam_instance_profile
}
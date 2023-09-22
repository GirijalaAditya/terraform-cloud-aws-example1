output "ec2_public_ip" {
  description = "EC2 Public IP Address"
  value = aws_instance.instance_1.public_ip
}

output "ec2_public_dns" {
  description = "EC2 Public DNS Name"
  value = aws_instance.instance_1.public_dns
}

output "ec2_private_ip" {
  description = "EC2 Private IP Address"
  value = aws_instance.instance_1.private_ip
}

output "ec2_private_dns" {
  description = "EC2 Private DNS Name"
  value = aws_instance.instance_1.private_dns
}
resource "aws_instance" "instance_1" {
  ami = var.ami-id
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = file("${path.module}/script.sh")
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  tags = {
    Name = "Instance-1"
    Environment = local.environment
    "Business_Division" = local.business_division
  }
}
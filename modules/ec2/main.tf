resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_config.ami
  instance_type = var.ec2_config.instance_type

  subnet_id = var.ec2_config.subnet_id

  tags = {
    Name = "${var.ec2_config.name}-ec2"
  }

  user_data                   = var.ec2_config.user_data
  associate_public_ip_address = var.ec2_config.public
  security_groups             = var.ec2_config.security_groups
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_config.ami
  instance_type = var.ec2_config.instance_type

  subnet_id = var.ec2_config.subnet_id

  tags = {
    Name = "${var.ec2_config.name}-ec2"
  }
}

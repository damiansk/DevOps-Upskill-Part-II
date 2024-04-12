resource "aws_launch_template" "main" {
  name_prefix = "${var.config.name}_"
  description = var.config.description
  # TODO: Better to use data source to find latest imgae
  # or define default with data source as a fallback
  image_id      = var.config.image_id # Amazon Linux 2023 AMI
  instance_type = "t2.micro"          # TODO: From variable with default

  user_data = var.config.user_data

  network_interfaces {
    associate_public_ip_address = var.config.public
    security_groups             = var.config.security_groups
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.config.name
    }
  }
}

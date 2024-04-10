resource "aws_launch_template" "main" {
  name_prefix = "${var.launch_template.name}_"
  description = var.launch_template.description
  # TODO: Better to use data source to find latest imgae
  # or define default with data source as a fallback
  image_id      = var.launch_template.image_id # Amazon Linux 2023 AMI
  instance_type = "t2.micro"                   # TODO: From variable with default

  user_data = var.launch_template.user_data

  network_interfaces {
    associate_public_ip_address = var.launch_template.public
    security_groups             = var.launch_template.sg
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.launch_template.name
    }
  }
}

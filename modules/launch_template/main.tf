resource "aws_launch_template" "main" {
  name_prefix = "${var.config.name}_"
  description = var.config.description
  # TODO: Better to use data source to find latest imgae
  # or define default with data source as a fallback
  # TODO Change image to craete new version
  image_id               = var.config.image_id # Canonical, Ubuntu, 22.04 LTS
  instance_type          = "t2.micro"          # TODO: From variable with default
  update_default_version = true

  user_data = var.config.user_data

  tags = {
    TemplateVersion = var.config.version
  }

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

  dynamic "iam_instance_profile" {
    for_each = [var.config.iam_profile]

    content {
      name = iam_instance_profile.value
    }
  }
}

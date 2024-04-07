// module
resource "aws_lb" "lb" {
  name               = var.lb.name
  internal           = var.lb.internal
  load_balancer_type = "application"
  security_groups    = [var.lb.sg]
  subnets            = var.lb.subnets

  tags = {
    Name = var.lb.name
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = var.tg.name
  vpc_id   = var.vpc_id
  port     = 80
  protocol = "HTTP"

  tags = {
    Name = var.tg.name
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

// module
resource "aws_launch_template" "lt" {
  name_prefix = "${var.lt.name}_"
  description = var.lt.description
  # Better to use data source to find latest imgae
  # or define default with data source as a fallback
  image_id      = "ami-0c101f26f147fa7fd" # Amazon Linux 2023 AMI
  instance_type = "t2.micro"              # From variable with default
  # Add template folder - at root level
  # Read file from template
  # Pass template content as a text
  user_data = var.lt.user_data

  network_interfaces {
    associate_public_ip_address = var.lt.public
    subnet_id                   = var.lt.subnet_id
    security_groups             = var.lt.sg
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.lt.name
    }
  }
}

// module
resource "aws_autoscaling_group" "ag" {
  name             = var.asg.name
  desired_capacity = 2
  max_size         = 2
  min_size         = 2

  vpc_zone_identifier = var.asg.subnets
  target_group_arns   = [aws_lb_target_group.lb_target_group.arn]

  launch_template {
    id      = aws_launch_template.lt.id
    version = aws_launch_template.lt.latest_version
  }
}


// Add main module (eg. application) which will create all from above

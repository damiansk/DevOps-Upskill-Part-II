resource "aws_lb" "main" {
  name               = var.config.name
  internal           = var.config.internal
  load_balancer_type = var.config.lb_type
  security_groups    = var.config.sg
  subnets            = var.config.subnets

  tags = {
    Name = var.config.name
  }
}

resource "aws_lb_target_group" "main" {
  name     = var.target_group.name
  vpc_id   = var.target_group.vpc_id
  port     = 80
  protocol = "HTTP"

  tags = {
    Name = var.target_group.name
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

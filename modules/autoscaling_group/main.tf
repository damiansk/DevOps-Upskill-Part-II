resource "aws_autoscaling_group" "main" {
  name = var.config.name

  desired_capacity = var.config.desired_capacity
  max_size         = var.config.max_size
  min_size         = var.config.min_size

  vpc_zone_identifier = var.config.subnets

  launch_template {
    id      = var.config.launch_template.id
    version = var.config.launch_template.version
  }

  instance_refresh {
    strategy = "Rolling"
  }
}
resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = aws_autoscaling_group.main.id
  lb_target_group_arn    = var.config.lb_target_group_arn
}

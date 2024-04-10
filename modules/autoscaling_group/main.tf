resource "aws_autoscaling_group" "main" {
  name = var.config.name

  desired_capacity = var.config.desired_capacity
  max_size         = var.config.max_size
  min_size         = var.config.min_size

  # TODO: Confirm if this one is correct
  vpc_zone_identifier = var.config.subnets
  target_group_arns   = [var.config.launch_template.arn]

  launch_template {
    id      = var.config.launch_template.id
    version = var.config.launch_template.latest_version
  }
}

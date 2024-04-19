resource "aws_security_group" "main" {
  vpc_id = var.config.vpc_id
  name   = "${var.config.name}-security-group"

  dynamic "ingress" {
    for_each = var.config.ingress

    content {
      description     = try(ingress.value.description, null)
      from_port       = try(ingress.value.from_port, null)
      to_port         = try(ingress.value.to_port, null)
      protocol        = try(ingress.value.protocol, null)
      cidr_blocks     = try(ingress.value.cidr_blocks, [])
      security_groups = ingress.value.security_groups != [] ? ingress.value.security_groups : []
    }
  }

  dynamic "egress" {
    for_each = var.config.egress

    content {
      description     = try(egress.value.description, null)
      from_port       = try(egress.value.from_port, null)
      to_port         = try(egress.value.to_port, null)
      protocol        = try(egress.value.protocol, null)
      cidr_blocks     = egress.value.cidr_blocks != [] ? egress.value.cidr_blocks : []
      security_groups = egress.value.security_groups != [] ? egress.value.security_groups : []
    }
  }

  tags = {
    Name = "${var.config.name}-security-group"
  }
}

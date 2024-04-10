resource "aws_subnet" "main" {
  vpc_id            = var.config.vpc_id
  cidr_block        = var.config.cidr_block
  availability_zone = var.config.availability_zone

  tags = var.config.tags
}

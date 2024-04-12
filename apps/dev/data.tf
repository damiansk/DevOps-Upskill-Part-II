data "aws_subnets" "public" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Visibility"
    values = ["public"]
  }

  # TODO add filtr for owner
}

data "aws_vpc" "main" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Name"
    values = ["dstolarek-upskill-vpc"]
  }

  # TODO add filtr for owner
}

# TODO: Use module directly instead
data "aws_security_group" "public-load_balancer" {
  filter {
    name   = "tag:Name"
    values = ["public-load_balancer-security-group"]
  }

  filter {
    name   = "tag:Application"
    values = ["DevOps Terraform Upskill"]
  }
}

data "aws_security_group" "public-launch_template" {
  filter {
    name   = "tag:Name"
    values = ["public-launch_template-security-group"]
  }

  filter {
    name   = "tag:Application"
    values = ["DevOps Terraform Upskill"]
  }
}

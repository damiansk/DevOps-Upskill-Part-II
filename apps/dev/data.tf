data "aws_subnets" "public" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Visibility"
    values = ["public"]
  }

  filter {
    name   = "tag:Owner"
    values = ["dstolarek"]
  }

  filter {
    name   = "tag:Version"
    values = ["180524"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Visibility"
    values = ["private"]
  }

  filter {
    name   = "tag:Owner"
    values = ["dstolarek"]
  }

  filter {
    name   = "tag:Version"
    values = ["180524"]
  }
}

data "aws_subnets" "database" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Destination"
    values = ["database"]
  }

  filter {
    name   = "tag:Owner"
    values = ["dstolarek"]
  }

  filter {
    name   = "tag:Version"
    values = ["180524"]
  }
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

  filter {
    name   = "tag:Owner"
    values = ["dstolarek"]
  }

  filter {
    name   = "tag:Version"
    values = ["180524"]
  }
}

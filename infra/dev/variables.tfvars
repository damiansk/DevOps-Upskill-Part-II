networking = {
  network = {
    name       = "dstolarek-upskill-vpc"
    cidr_block = "10.0.0.0/16"
    subnets = [
      {
        name              = "public-1"
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1a"
        tags = {
          Name       = "public-1-east-1a"
          Visibility = "public"
        }
      },
      {
        name              = "public-2"
        cidr_block        = "10.0.2.0/24"
        availability_zone = "us-east-1b"
        tags = {
          Name       = "public-1-east-1b"
          Visibility = "public"
        }
      },
      {
        name              = "private-1"
        cidr_block        = "10.0.11.0/24"
        availability_zone = "us-east-1a"
        tags = {
          Name       = "private-1-east-1a"
          Visibility = "private"
        }
      },
      {
        name              = "private-2"
        cidr_block        = "10.0.12.0/24"
        availability_zone = "us-east-1b"
        tags = {
          Name       = "private-2-east-1b"
          Visibility = "private"
        }
      },
      {
        name              = "private-db-1"
        cidr_block        = "10.0.13.0/24"
        availability_zone = "us-east-1a"
        tags = {
          Name        = "private-db-1-east-1a"
          Destination = "database"
        }
      },
      {
        name              = "private-db-2"
        cidr_block        = "10.0.14.0/24"
        availability_zone = "us-east-1b"
        tags = {
          Name        = "private-db-2-east-1b"
          Destination = "database"
        }
      },
    ],
  },
  igw = {
    resource_name = "igw"
  }
  nat = {
    resource_name = "nat"
  }
}

ec2_pipeline = {
  ami           = "ami-080e1f13689e07408" # Canonical, Ubuntu, 22.04 LTS
  instance_type = "t2.micro"
  name          = "pipeline_ec2"
  runner_token  = "xyz"
}


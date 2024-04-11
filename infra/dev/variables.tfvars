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
          Name = "public-1-east-1a"
        }
      },
      {
        name              = "public-2"
        cidr_block        = "10.0.2.0/24"
        availability_zone = "us-east-1b"
        tags = {
          Name = "public-1-east-1b"
        }
      },
      {
        name              = "private-1"
        cidr_block        = "10.0.11.0/24"
        availability_zone = "us-east-1a"
        tags = {
          Name = "private-1-east-1a"
        }
      },
      {
        name              = "private-2"
        cidr_block        = "10.0.12.0/24"
        availability_zone = "us-east-1b"
        tags = {
          Name = "private-2-east-1b"
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

  security_groups = [
    {
      name = "public"
      }, {
      name = "private"
    }
  ]
}

ec2 = {
  ami           = "ami-0c101f26f147fa7fd" # Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  name          = "pipeline_ec2"
}


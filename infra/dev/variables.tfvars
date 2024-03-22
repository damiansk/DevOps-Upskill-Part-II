networking = {
  network = {
    vpc = {
      resource_name = "vpc"
      cidr_block    = "10.0.0.0/16"
    }
    subnets = [
      {
        name              = "public"
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1a"
        tags = {
          Name = "public-subnet"
        }
      },
      {
        name              = "private"
        cidr_block        = "10.0.3.0/24"
        availability_zone = "us-east-1a"
        tags = {
          Name = "private-subnet"
        }
      },
    ],
    igw = {
      resource_name = "igw"
    }
    nat = {
      resource_name = "nat"
    }
  }

  security_groups = {
    public = {
      resource_name = "public_sg"
    }
    private = {
      resource_name = "private_sg"
    }
  }
}

ec2 = {
  ami           = "ami-0c101f26f147fa7fd" # Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  name          = "pipeline_ec2"
}


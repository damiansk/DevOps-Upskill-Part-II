variable "networking" {
  type = object({
    network = object({
      name       = string
      cidr_block = string
      subnets = list(object({
        name              = string
        cidr_block        = string
        availability_zone = string
        tags              = map(string)
      }))
    })
    igw = object({
      resource_name = string
    })
    nat = object({
      resource_name = string
    })
    security_groups = object({
      public = object({
        resource_name = string
      })
      private = object({
        resource_name = string
      })
    })
  })

  validation {
    condition     = can([for subnet in var.networking.network.subnets : regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", subnet.cidr_block)])
    error_message = "The CIDR block is invalid."
  }
}

variable "ec2" {
  type = object({
    ami           = string
    instance_type = string
    name          = string
  })
}

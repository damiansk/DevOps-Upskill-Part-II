variable "networking" {
  type = object({
    network = object({
      vpc = object({
        resource_name = string
        cidr_block    = string
      })
      subnets = list(object({
        name              = string
        cidr_block        = string
        availability_zone = string
        tags              = map(string)
      }))
      igw = object({
        resource_name = string
      })
      nat = object({
        resource_name = string
      })
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
}

variable "networking" {
  type = object({
    network = object({
      cidr_block = string
      name       = string

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
  })
}

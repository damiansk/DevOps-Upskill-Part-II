variable "config" {
  type = object({
    vpc_id            = string
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  })
}

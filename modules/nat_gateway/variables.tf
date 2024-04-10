variable "config" {
  type = object({
    name      = string
    vpc_id    = string
    subnet_id = string
  })
}

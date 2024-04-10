variable "config" {
  type = object({
    vpc_id = string
    name   = string
  })
}

variable "ec2_config" {
  type = object({
    ami           = string
    instance_type = string
    subnet_id     = string
    name          = string
  })
}

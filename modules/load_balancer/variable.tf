variable "vpc_id" {
  type = string
}

variable "lb" {
  type = object({
    name     = string
    internal = string
    sg       = string
    subnets  = list(string)
  })
}

variable "tg" {
  type = object({
    name = string
  })
}

variable "lt" {
  type = object({
    name        = string
    description = string
    user_data   = string
    public      = bool
    subnet_id   = string
    sg          = list(string)
  })
}

variable "asg" {
  type = object({
    name    = string
    subnets = list(string)
  })
}

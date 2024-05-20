variable "config" {
  type = object({
    name        = string
    description = string
    version     = string

    user_data = string

    public          = bool
    security_groups = list(string)

    # TODO: Use data-source as a fallback
    image_id = optional(string, "ami-080e1f13689e07408")

    iam_profile = optional(string)
  })
}

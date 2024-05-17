resource "aws_iam_instance_profile" "main" {
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  name               = "${var.config.name}-iam-role"
  assume_role_policy = data.aws_iam_policy_document.main.json
}

data "aws_iam_policy_document" "main" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "main" {
  for_each = { for policy in var.config.policies : policy.name => policy }

  name   = "${each.value.name}-iam-policy"
  policy = each.value.policy
}

resource "aws_iam_role_policy_attachment" "main" {
  for_each = aws_iam_policy.main

  role       = aws_iam_role.main.name
  policy_arn = each.value.arn
}

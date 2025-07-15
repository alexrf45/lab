

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${var.env}-${var.app}-${random_uuid.this.result}",
      "arn:aws:s3:::${var.env}-${var.app}-${random_uuid.this.result}/*",
    ]
  }
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.env}-${var.app}-role-policy"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.this.json
}


resource "aws_iam_role" "this" {
  name = "${var.env}-${var.app}-role-${random_uuid.this.result}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = aws_iam_user.this.arn
        }
      },
    ]
  })
}

# Create the IAM user
resource "aws_iam_user" "this" {
  name = var.username
  path = var.path

  tags = {
    Environment = var.env
    Application = var.app
    Owner       = var.username
  }
}
resource "aws_iam_user_policy" "this" {
  name   = "${var.env}-${var.app}-user-policy-${random_uuid.this.result}"
  user   = aws_iam_user.this.name
  policy = data.aws_iam_policy_document.this.json
}

# resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
#   user       = aws_iam_user.user.name
#   policy_arn = aws_iam_user_policy.policy.arn
# }

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

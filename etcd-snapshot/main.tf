

data "aws_caller_identity" "current" {}

resource "random_uuid" "test" {
}

resource "aws_s3_bucket" "etcd" {
  bucket = "${var.env}-${var.app}-${random_uuid.test.result}"
  tags   = var.resource_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.etcd.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.etcd.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_policy" "backend" {
  bucket = aws_s3_bucket.etcd.id
  policy = data.aws_iam_policy_document.s3-backend.json
}



data "aws_iam_policy_document" "s3-backend" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        data.aws_caller_identity.current.arn,

        aws_iam_user.etcd.arn,
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${var.env}-${var.app}-${random_uuid.test.result}",
      "arn:aws:s3:::${var.env}-${var.app}-${random_uuid.test.result}/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.etcd.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_user" "etcd" {
  name = "${var.env}-${var.app}-etcd-user"
  path = var.path

  tags = var.resource_tags
}

resource "aws_iam_access_key" "etcd_key" {
  user = aws_iam_user.etcd.name
}

resource "aws_iam_user_policy" "etcd_access" {
  name = "${var.env}-${var.app}-${random_uuid.test.result}"
  user = aws_iam_user.etcd.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [

          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.env}-${var.app}-${random_uuid.test.result}",
          "arn:aws:s3:::${var.env}-${var.app}-${random_uuid.test.result}/*",
        ]
      }
    ]
  })
}


data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "objstorage001"
    effect = "Allow"
    principals {
      type = "AWS"

      identifiers = [
        data.aws_caller_identity.current.arn,
        aws_iam_user.this.arn,
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${var.env}-${var.app}-${var.owner}-${random_uuid.this.result}",
      "arn:aws:s3:::${var.env}-${var.app}-${var.owner}-${random_uuid.this.result}/*",
    ]
  }
}

resource "random_uuid" "this" {
}

resource "aws_s3_bucket" "this" {
  bucket        = "${var.env}-${var.app}-${var.owner}-${random_uuid.this.result}"
  force_destroy = var.env == "dev" ? true : false
  tags = {
    Environment = var.env
    Application = var.app
    Owner       = var.username
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




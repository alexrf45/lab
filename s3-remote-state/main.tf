data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${var.env}-${var.app}-state"
  force_destroy = var.env == "dev" ? true : false
  tags = {
    Environment = var.env
    Application = var.app
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "backend" {
  bucket = aws_s3_bucket.terraform_state.id
  policy = data.aws_iam_policy_document.s3-backend.json
}



data "aws_iam_policy_document" "s3-backend" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "${data.aws_caller_identity.current.arn}"
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${var.env}-${var.app}-state",
      "arn:aws:s3:::${var.env}-${var.app}-state/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.env}-${var.app}-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

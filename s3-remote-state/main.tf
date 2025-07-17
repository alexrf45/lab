data "aws_caller_identity" "current" {}

resource "random_uuid" "this" {
}


resource "aws_s3_bucket" "this" {
  bucket        = "${var.env}-${var.app}-state-${random_uuid.this.result}"
  force_destroy = var.env == "dev" ? true : false
  tags          = var.resource_tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
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



data "aws_iam_policy_document" "this" {
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
      "arn:aws:s3:::${var.env}-${var.app}-state-${random_uuid.this.result}",
      "arn:aws:s3:::${var.env}-${var.app}-state-${random_uuid.this.result}/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_dynamodb_table" "this" {
  name         = "${var.env}-${var.app}-dynamodb-table-${random_uuid.this.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.resource_tags
}

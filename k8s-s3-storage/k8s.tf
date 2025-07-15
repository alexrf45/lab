resource "random_id" "this" {
  byte_length = 8
}

resource "kubernetes_secret" "this" {
  count = var.create_k8s_secret ? 1 : 0
  metadata {
    name      = "${var.env}-${var.app}-${var.owner}-${random_id.secret-id.id}"
    namespace = var.app
    labels = {
      environment = var.env
      app         = var.app
      owner       = var.owner
    }
  }
  data = {
    AWS_ACCESS_KEY_ID     = aws_iam_access_key.this.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.this.secret
    AWS_ROLE_ARN          = aws_iam_role.this.arn
    BUCKET                = aws_s3_bucket.this.id
  }
}

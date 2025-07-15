terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

provider "aws" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "nextcloud" {
  source     = "./module/"
  env        = "dev"
  app        = "test"
  owner      = "test-user"
  username   = "test"
  path       = "/dev/app/storage/"
  versioning = "Disabled"
}

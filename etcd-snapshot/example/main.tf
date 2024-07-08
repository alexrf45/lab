terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {

  }
}

provider "aws" {

}


module "etcd_snapshot" {
  source = "github.com/alexrf45/lab.git//etcd-snapshot?ref=v0.0.3-etcd-test"
  env    = "dev"
  app    = "s3_etcd"
  resource_tags = {
    project    = "k3s_s3_etcd_fr3d"
    enviroment = "dev"
    Name       = "k3s_s3_etcd_snapshot_store"
  }
  versioning = "Disabled"
  path       = "/prod/k3s/s3-etcd"
}

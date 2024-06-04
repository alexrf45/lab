terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "5.46.0"
      configuration_aliases = [aws.west, aws.east]
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.30.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

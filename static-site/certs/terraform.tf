terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "5.46.0"
      configuration_aliases = [aws.east]
    }
  }
}



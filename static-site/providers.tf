provider "aws" {
  alias  = "east"
  region = var.aws_region_2
}

provider "aws" {
  alias  = "west"
  region = var.aws_region
}

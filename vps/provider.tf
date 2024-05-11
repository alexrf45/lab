provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Name      = "AWS Virtual Private Server"
      Purpose   = "Virtual Private Server"
      ManagedBy = "Terraform"
    }
  }
}
provider "tls" {

}

provider "cloudinit" {

}

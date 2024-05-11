# AWS Virtual Private Server

- A simple module for spinning up an EC2 instance for general use

- See example folder for module use

- Module is built assuming deployment is initialized from local machine. Development for use on runners is not in the works at this time

- Install script is still in testing. ensure install script is located in parent directory before deploying

## Provider block:

```hcl
provider "aws" {
  region = "us-west-2"
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
```


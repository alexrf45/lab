variable "env" {
  description = "code/app environement"
  type        = string
  default     = "dev"
  validation {
    condition = anytrue([
      var.env == "dev",
      var.env == "stage",
      var.env == "prod",
      var.env == "testing"
    ])
    error_message = "Please use one of the approved environement names: dev, stage, prod, testing"
  }
}

variable "app" {
  description = "app or project name"
  type        = string
  default     = ""
  validation {
    condition     = length(var.app) > 4
    error_message = "app name must be at least 4 characters"
  }
}


variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "file_path" {
  description = "file path for cloud init script"
  type        = string
  default     = "./install.sh"
}

variable "ssh_key_path" {
  description = "path of local ssh key"
  type        = string
}

variable "shell" {
  description = "default user's shell"
  type        = string
  default     = "/bin/bash"
}

variable "ami" {
  description = "Amazon Machine Image"
  type        = string
  default     = "ami-052efd3df9dad4825"

}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3a.medium"
}

variable "volume_size" {
  description = "Size of Volume"
  type        = string
  default     = "50"

}

variable "volume_type" {
  description = "Type of volume"
  type        = string
  default     = "gp2"

}

variable "associate_public_ip_address" {
  description = "Whether to associate public IP to EC2 Instance"
  type        = bool
  default     = true
}


variable "username" {
  description = "username for vps instance"
  type        = string
  default     = ""
}

variable "sg_name" {
  description = "Name of security group"
  type        = string
  default     = "bounty_sg"
}


variable "sg_description" {
  description = "Description of security group"
  type        = string
  default     = "SSH & HTTP/HTTPS"
}


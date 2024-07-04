variable "file_path" {
  description = "location of cloud init shell script"
  type        = string
  default     = "./install.sh"
}

variable "username" {
  description = "cloud init user"
  type        = string
  default     = "admin"

}


variable "shell" {
  description = "user's default shell"
  type        = string
  default     = "/bin/bash"
}

variable "ssh_public_key" {
  description = "public key used for ssh access"
  type        = string
}

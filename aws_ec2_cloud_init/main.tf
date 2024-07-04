#creates ssh key pair for ec2 access via ssh w/ local ssh key
resource "aws_key_pair" "ssh_access" {
  key_name_prefix = "${var.region}-${var.env}-${var.app}-ssh"
  public_key      = tls_private_key.ssh_key.public_key_openssh
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#reserves a AWS Elastic IP
resource "aws_eip" "eip" {
}

#Associates Elastic IP to ec2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.instance.id
  allocation_id = aws_eip.eip.allocation_id
}

data "cloudinit_config" "test" {
  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      users = [
        #        "default", # when commented, default user (ec2-user, etc...) will not be created
        {
          name                = var.username # new username
          shell               = "/bin/bash"
          sudo                = "ALL=(ALL) NOPASSWD:ALL"
          ssh_authorized_keys = [tls_private_key.ssh_key.public_key_openssh] #ssh-keygen -t ed25519 -C "web" -N '' -f ~/.ssh/web
        }
      ]
    })
  }
  part { #useful for bootstrapping the instance
    filename     = "./install.sh"
    content_type = "text/x-shellscript"
    content      = file("./install.sh")
  }
}

#creates ec2 instance
resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.ssh_access.key_name
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  user_data                   = data.cloudinit_config.test.rendered
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    Environment = var.env
    App         = var.app
    Region      = var.region
  }
}

#create security group for ssh,http,https access
resource "aws_security_group" "web_sg" {
  name        = var.sg_name
  description = var.sg_description
}

#sets local variables for security group rules
locals {
  http_port    = 80
  https_port   = 443
  ssh_port     = 22
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

#security group rules seperated out to allow for modifications
resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id
  description       = var.sg_description
  from_port         = local.ssh_port
  to_port           = local.ssh_port
  protocol          = local.tcp_protocol
  cidr_blocks       = local.all_ips
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id
  description       = var.sg_description

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id
  description       = var.sg_description

  from_port   = local.https_port
  to_port     = local.https_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.web_sg.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips

}


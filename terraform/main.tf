terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "uptime_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "uptime_sg" {
  name        = "uptime-monitor-sg"
  description = "Allow SSH, HTTP, and monitoring ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "uptime_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.uptime_key.key_name
  vpc_security_group_ids = [aws_security_group.uptime_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io docker-compose
              systemctl start docker
              systemctl enable docker
              EOF

  tags = { Name = "uptime-monitor" }
}

output "instance_public_ip" {
  value = aws_instance.uptime_instance.public_ip
}

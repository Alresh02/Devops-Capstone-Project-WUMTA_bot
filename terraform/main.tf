provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "uptime_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io docker-compose
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "UptimeMonitor"
  }
}

output "ec2_public_ip" {
  value = aws_instance.uptime_ec2.public_ip
}

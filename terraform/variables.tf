variable "aws_region"      { default = "ap-south-1" }
variable "instance_type"   { default = "t3.micro" }
variable "key_name"        { description = "new-jen-key-pair" }
variable "public_key_path" { description = "/home/resh/.ssh/uptime_key.pub" }
variable "my_ip_cidr"      { default = "0.0.0.0/0" }

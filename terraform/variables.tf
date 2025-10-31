variable "aws_region"      { default = "ap-south-1" }
variable "instance_type"   { default = "t3.micro" }
variable "key_name"        { description = "terraform-key" }
variable "public_key_path" { description = "Path to your .pub file" }
variable "my_ip_cidr"      { default = "0.0.0.0/0" }

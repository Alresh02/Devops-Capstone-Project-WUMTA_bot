variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name (create or provide in AWS console)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use (Ubuntu 22.04 LTS example)"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

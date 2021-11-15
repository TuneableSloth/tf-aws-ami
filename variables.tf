variable "aws_region" {
  default     = "eu-west-1"
}

variable "aws_ami" {
  default = {
    "eu-west-1" = "ami-00035f41c82244dab"
  }
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "min_instance" {
  description = "Min numbers of servers auto scaling group"
  default     = "1"
}

variable "max_instance" {
  description = "Max numbers of servers auto scaling group"
  default     = "2"
}

variable "desired_instances" {
  description = "Desired numbers of servers in auto scaling group"
  default     = "1"
}
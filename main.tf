terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region = "${var.aws_region}"
}

resource "aws_autoscaling_group" "backbase-asgnmnt-ami" {
  availability_zones   = "${data.aws_availability_zones.available.names}"
  name                 = "backbase-asgnmnt-ami"
  max_size             = "${var.max_instance}"
  min_size             = "${var.min_instance}"
  desired_capacity     = "${var.desired_instances}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.my-centos-ami.name}"
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "backbase-asgnmnt-ami"
  }
}

resource "aws_launch_configuration" "centos-ami" {
  name          = "centos-ami"
  image_id      = "${data.aws_ami.centos_ami.id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.default.id}"]
  user_data       = "${file("startup.sh")}"
  key_name        = "${var.key_name}"
}

resource "aws_security_group" "default" {
  name        = "centos_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 8080
    to_port     = 8080
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

data "aws_availability_zones" "available" {
    state = "available"
}

data "aws_ami" "centos_ami" {
  owners      = ["679593333241"] # CentOS Project
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.8.0"
        }
    }
}

provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "web" {
    ami = "ami-03e88be9ecff64781" //Amazon Linux2
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web.id]
    user_data = file("user_data.sh")
    tags = {
      "Name" = "WebServer Built by Terraform"
      "Owner" = "Sukanya"
    }
}

resource "aws_security_group" "web" {
    name = "WebServer-SG"
    description = "Security Group for my WebServer"

    ingress {
      description = "Allow port HTTP"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description = "Allow port HTTPS"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      description = "Allow ALL ports"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      "Name" = "WebServer SG by Terraform"
      "Owner" = "Sukanya"
    }
}
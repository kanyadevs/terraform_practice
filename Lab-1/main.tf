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

resource "aws_instance" "my_linux" {
  ami           = "ami-03e88be9ecff64781"
  instance_type = "t2.micro"
  key_name = "terraformkp"

  tags = {
    Name = "My-Linux"
    Owner = "Sukanya"
    project = "Phoenix"
  }
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0015a39e4b7c0966f"
  instance_type = "t2.micro"

  tags = {
    Name = "My-Ubuntu-Server"
    Owner = "Sukanya"
  }
}
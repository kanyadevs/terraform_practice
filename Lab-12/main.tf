terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.8.0"
        }
    }
}

provider "aws" {
    region = "us-west-2"
}


data "aws_ami" "latest_ubuntu" {
    owners = ["099720109477"] 
    mostmost_recent = true
    filter{
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    } 
}

data "aws_ami" "latest_linux2" {
    owners = ["137112412989"] 
    mostmost_recent = true
    filter{
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    } 
}

data "aws_ami" "latest_windowsserver" {
    owners = ["801119661308"] 
    mostmost_recent = true
    filter{
        name = "name"
        values = ["Windows_Server-2019-English-Full-Base-*"]
    } 
}

output "latest_ubuntu_ami" {
    value = data.aws_ami.latest_ubuntu.id
}

output "latest_linux2_ami" {
    value = data.aws_ami.latest_linux2.id
}

output "latest_windows_ami" {
    value = data.aws_ami.latest_windowsserver.id
}
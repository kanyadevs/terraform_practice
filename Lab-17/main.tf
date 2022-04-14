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

resource "null_resource" "command1" {
    provisioner "local-exec" {
        command = "echo Terraform START: $(date) >> log.txt"
    }
}

resource "null_resource" "command2" {
    provisioner "local-exec" {
        command = "ping -c 5 www.google.com"
    }
}

resource "null_resource" "command3" {
    provisioner "local-exec" {
        interpreter = ["python", "-c"]
        command = "print('Hello World from Python!')"
    }
}

resource "null_resource" "command4" {
    provisioner "local-exec" {
        command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
        environment = {
          NAME1 = "Bob"
          NAME2 = "Mark"
          NAME3 = "John"
         }
    }
}

resource "aws_instance" "my_server" {
    ami = "ami-03e88be9ecff64781"
    instance_type = "t2.micro"
    provisioner "local-exec" {
        command = "echo ${aws_instance.myserver.private_ip} >> log.txt"
    }
}

resource "null_resource" "command5" {
    provisioner "local-exec" {
        command = "echo Terraform FINISH: $(date) >> log.txt"
    }

    depends_on = [
      null_resource.command1,
      null_resource.command2,
      null_resource.command3,
      null_resource.command4,
      null_resource.command5,
      aws_instance.myserver
    ]
  
}
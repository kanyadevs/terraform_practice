#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Loop Construct: for x in xyz:
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "eu-west-2"
}


resource "aws_iam_user" "user" {
  for_each = toset(var.aws_users)
  name     = each.value
}

resource "aws_instance" "my_server" {
  count         = 4
  ami           = "ami-034ef92d9dd822b08"
  instance_type = "t2.micro"
  tags = {
    Name  = "Server-${count.index + 1}"
    Owner = "Sukanya C"
  }
}
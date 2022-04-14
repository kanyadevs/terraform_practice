terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.8.0"
        }
    }
}

provider "aws" {
  
}

data "aws_region" "current" {
  
}

output "region_name" {
    value = data.aws_region.current.name
}

output "region_description" {
    value = data.aws_region.current.description
}
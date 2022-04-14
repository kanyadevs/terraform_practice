terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.8.0"
        }
    }
}

provider "aws" {}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zone" "working" {
  
}

output "region_name" {
    value = data.aws_region.current.name
}

output "region_description" {
    value = data.aws_region.current.description
}

output "account_id" {
    value = data.aws_caller_identity.current.account_id
}

output "availability_zone" {
    value = data.aws_availability_zone.working.name
}
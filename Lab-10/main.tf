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

resource "aws_db_instance" "prod" {
    identifier = "prod-mysql-rds"
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.micro"
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
    apply_immediately = true
    username = "administrator"
    password = random_password.main.result
}

// Generate Password
resource "random_password" "main" {
    length = 20
    special = true
    override_special = "#!()_"
}



#-----------------------
output "rds_address" {
    value = aws_db_instance.prod.address
}

output "rds_port" {
    value = aws_db_instance.prod.port
}

output "rds_username" {
    value = aws_db_instance.prod.username
}

output "rds_password" {
    value = random_password.main.result
    sensitive = true
}
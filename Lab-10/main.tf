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
    password = data.aws_secretsmanager_secret_version.rds_password.secret_string
}

// Generate Password
resource "random_password" "main" {
    length = 20
    special = true
    override_special = "#!()_"
}

// Store Password
resource "aws_secretsmanager_secret" "rds_password" {
    name = "/prod/rds/password"
    description = "Password for my RDS database"
    recovery_window_in_days = 0
  
}

//Store All RDS parameters
resource "aws_secretsmanager_secret" "rds" {
    name = "/prod/rds/all"
    description = "All details for my RDS Database"
    recovery_window_in_days = 0
  
}

resource "aws_secretsmanager_secret_version" "rds" {
    secret_id = aws_secretsmanager_secret.rds_password.id
    secret_string = jsonencode({
        rds_address = aws_db_instance.prod.address
        rds_port = aws_db_instance.prod.port
        rds_username = aws_db_instance.prod.username
    })
}

resource "aws_secretsmanager_secret_version" "rds_password" {
    secret_id = aws_secretsmanager_secret.rds.id
    secret_string = random_password.main.result
}

//Retrieve Password
data "aws_secretsmanager_secret_version" "rds_password" {
    secret_id = aws_secretsmanager_secret.rds_password.id
    depends_on = [
      aws_secretsmanager_secret_version.rds_password
    ]
}

//Retrieve ALL
data "aws_secretsmanager_secret_version" "rds_password" {
    secret_id = aws_secretsmanager_secret.rds.id
    depends_on = [
      aws_secretsmanager_secret_version.rds
    ]
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

output "rds_all" {
    value = jsonencode(data.aws_secretsmanager_secret_version.rds.secret_string)
  
}


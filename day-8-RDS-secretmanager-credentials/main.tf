# Create a simple VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "rds-vpc"
  }
}

# Create 2 subnets in different AZs
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "rds-subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"


  tags = {
    Name = "rds-subnet-2"
  }
}

# Create DB subnet group using above subnets

resource "aws_db_subnet_group" "sub_grp" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  tags = {
    Name = "My RDS Subnet Group"
  }
}



# Create and store RDS credentials in Secrets Manager

resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "rds-credentials"
  description = "RDS MySQL admin credentials"
}

# Generate a random password
resource "random_password" "rds_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.rds_password.result
  })
}

# Decode the JSON secret for use in Terraform
locals {
  rds_creds = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)
}

# Create a RDS instance

resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  identifier              = "rds-test"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = local.rds_creds.username
  password                = local.rds_creds.password
  db_subnet_group_name    = aws_db_subnet_group.sub_grp.id
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot         = true
  #final_snapshot_identifier   = "rds-test-final-snapshot-1"


  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring (CloudWatch Enhanced Monitoring)
  #monitoring_interval      = 60  # Collect metrics every 60 seconds
  #monitoring_role_arn      = aws_iam_role.rds_monitoring.arn

  # Enable performance insights
  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7  # Retain insights for 7 days

  # Maintenance window
  #maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  #deletion_protection = true

  # Skip final snapshot
  #skip_final_snapshot = true
}

# # # IAM Role for RDS Enhanced Monitoring
# resource "aws_iam_role" "rds_monitoring" {
#   name = "rds-monitoring-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "monitoring.rds.amazonaws.com"
#       }
#     }]
#   })
# }

#IAM Policy Attachment for RDS Monitoring
# resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
#   role       = aws_iam_role.rds_monitoring.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
# }


# resource "aws_db_subnet_group" "sub-grp" {
#   name       = "mycutsubnet"
#   subnet_ids = ["subnet-07395049b5d813a79", "subnet-0d2209bc56450d423"]

#   tags = {
#     Name = "My DB subnet group"
#   }
# }




####### with data source ###########
# data "aws_subnet" "subnet_1" {
#   filter {
#     name   = "tag:Name"
#     values = ["subnet-1"]
#   }
# }

# data "aws_subnet" "subnet_2" {
#   filter {
#     name   = "tag:Name"
#     values = ["subnet-2"]
#   }
# }
# resource "aws_db_subnet_group" "sub-grp" {
#   name       = "mycutsubnet"
#   subnet_ids = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]

#   tags = {
#     Name = "My DB subnet group"
#   }
# }

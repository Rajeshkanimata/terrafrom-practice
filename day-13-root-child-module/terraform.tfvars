region            = "us-east-1"

# VPC and Subnets
vpc_cidr          = "10.0.0.0/16"
vpc_name          = "TEST-TF-MODULE-VPC"
public_subnet_1   = "10.0.1.0/24"
public_subnet_2   = "10.0.2.0/24"
az_1              = "us-east-1a"
az_2              = "us-east-1b"

# EC2
ami_id            = "ami-0baad21d595ffd6dc"
instance_type     = "t3.micro"
instance_name     = "ec2-tf-module"

# RDS
db_subnet_group_name = "my-db-subnet-group"
db_identifier        = "db-tf-module"
engine               = "mysql"
instance_class       = "db.t3.micro"
allocated_storage    = 20
username             = "admin"
password             = "cloud123"

#RDS-SECRET-MANAGER-RANDOM-PASSWORD

# db_identifier        = "my-rds-db"
# engine               = "mysql"
# instance_class       = "db.t3.micro"
# allocated_storage    = 20
# username             = "admin"
# db_subnet_group_name = "rds-subnet-group"

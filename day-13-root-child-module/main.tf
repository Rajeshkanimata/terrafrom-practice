provider "aws" {
  region = var.region
}

# ---------------- VPC Module ----------------
module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  vpc_name         = var.vpc_name
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  az_1             = var.az_1
  az_2             = var.az_2
}

# ---------------- EC2 Module ----------------
module "ec2" {
  source         = "./modules/ec2"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = module.vpc.subnet_1_id
  instance_name  = var.instance_name
}

# ---------------- RDS Module ----------------
module "rds" {
  source                = "./modules/rds"
  db_subnet_group_name  = var.db_subnet_group_name
  subnet_ids            = [module.vpc.subnet_1_id, module.vpc.subnet_2_id]
  db_identifier         = var.db_identifier
  engine                = var.engine
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  username              = var.username
  password              = var.password
}

# -----------RDS-SECRET-MANAGER-RANDOM-PASSWORD-----------

#USE THIS IF YOU WANT RANDOM PASSWORD IN SECRET MANAGER

# module "db" {
#   source                = "./modules/db"
#   db_identifier         = var.db_identifier
#   engine                = var.engine
#   instance_class        = var.instance_class
#   allocated_storage     = var.allocated_storage
#   username              = var.username
#   db_subnet_group_name  = var.db_subnet_group_name
#   subnet_ids            = [module.vpc.subnet_1_id, module.vpc.subnet_2_id]
# }

# # ---------------- Outputs ----------------
# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "ec2_public_ip" {
#   value = module.ec2.public_ip
# }

# output "rds_endpoint" {
#   value = module.db.rds_endpoint
# }

# output "secret_arn" {
#   value = module.db.secret_arn
# }
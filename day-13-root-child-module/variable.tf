#--------------VPC----------

variable "region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_subnet_1" {}
variable "public_subnet_2" {}
variable "az_1" {}
variable "az_2" {}

#------------EC2-------------

variable "ami_id" {}
variable "instance_type" {}
variable "instance_name" {}

#-----------RDS-SELF-CREDENTIALS---------

variable "db_subnet_group_name" {}
variable "db_identifier" {}
variable "engine" {}
variable "instance_class" {}
variable "allocated_storage" {}
variable "username" {}
variable "password" {}

#--------------RDS-SECRET-MANAGER-RANDOM-PASSWORD-------------

# variable "db_identifier" {}
# variable "engine" {}
# variable "instance_class" {}
# variable "allocated_storage" {}
# variable "username" {}
# variable "db_subnet_group_name" {}
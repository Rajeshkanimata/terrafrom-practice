variable "db_identifier" {
  description = "RDS instance name"
  type        = string
}

variable "engine" {
  description = "Database engine (mysql, postgres, etc.)"
  type        = string
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size in GB"
  type        = number
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for DB subnet group"
  type        = list(string)
}

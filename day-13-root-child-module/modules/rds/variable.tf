variable "db_subnet_group_name" {
  description = "Name of the DB Subnet Group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for DB Subnet Group"
  type        = list(string)
}

variable "db_identifier" {
  description = "RDS DB identifier"
  type        = string
}

variable "engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
}

variable "instance_class" {
  description = "DB instance type"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
}

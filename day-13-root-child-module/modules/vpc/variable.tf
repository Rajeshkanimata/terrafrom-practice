variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}

variable "public_subnet_1" {
  description = "CIDR block for subnet 1"
  type        = string
}

variable "public_subnet_2" {
  description = "CIDR block for subnet 2"
  type        = string
}

variable "az_1" {
  description = "Availability Zone for subnet 1"
  type        = string
}

variable "az_2" {
  description = "Availability Zone for subnet 2"
  type        = string
}

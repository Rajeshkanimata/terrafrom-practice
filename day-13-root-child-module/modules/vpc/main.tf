# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Subnet 1 in first AZ
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_1
  availability_zone       = var.az_1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

# Subnet 2 in second AZ
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_2
  availability_zone       = var.az_2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

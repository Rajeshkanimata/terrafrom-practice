# Create a VPC
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "custom-vpc"
  }
}

# Create public subnet
resource "aws_subnet" "name-1" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "custom-public-subnet"
  }
}

# Create private subnet
resource "aws_subnet" "name-2" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "custom-private-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "custom-igw"
  }
}

# Public Route Table
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }

  tags = {
    Name = "public-RT"
  }
}

# Associate public subnet with route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.name-1.id
  route_table_id = aws_route_table.name.id
}

# Elastic IP for NAT
resource "aws_eip" "name" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "name" {
  subnet_id     = aws_subnet.name-1.id
  allocation_id = aws_eip.name.id
  tags = {
    Name = "custom-nat"
  }
  depends_on = [aws_internet_gateway.name]
}

# Private Route Table (for NAT)
resource "aws_route_table" "name-1" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.name.id
  }

  tags = {
    Name = "private-RT"
  }
}

# Associate private subnet with private route table
resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.name-1.id
  subnet_id      = aws_subnet.name-2.id
}

# Security Group
resource "aws_security_group" "name" {
  name   = "allow-http"
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "custom-sg"
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Public EC2 Instance
resource "aws_instance" "name" {
  ami                         = "ami-00ecbb8ba07f65d41"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.name-1.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  associate_public_ip_address = true
  tags = {
    Name = "public-ec2"
  }
}

# Private EC2 Instance
resource "aws_instance" "name-1" {
  ami                         = "ami-00ecbb8ba07f65d41"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.name-2.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  associate_public_ip_address = true
  tags = {
    Name = "private-ec2"
  }
}


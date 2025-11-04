resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.my_vpc.id
}

resource "aws_instance" "my_instance" {
  ami           = ""
  instance_type = ""
  subnet_id     = aws_subnet.my_subnet.id
}


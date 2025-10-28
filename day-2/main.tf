resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.my_vpc.id
}

resource "aws_instance" "my_instance" {
  ami           = "ami-00ecbb8ba07f65d41"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.my_subnet.id
}


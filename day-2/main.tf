resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "name" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.name.id
}

resource "aws_instance" "name" {
    ami = "ami-00ecbb8ba07f65d41"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.name.id
}

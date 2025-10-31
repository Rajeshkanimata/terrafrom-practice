resource "aws_instance" "name" {
 ami = "ami-00ecbb8ba07f65d41"
 instance_type = "t3.micro"
 tags = {
   Name = "test"
 }
}

resource "aws_s3_bucket" "name" {
  bucket = "kanimatabucket"
}

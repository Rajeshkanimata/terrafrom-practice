#Count without VAR

#count is used to create the number of instances we need if we want we can use var.tf here to mention name 
#for each instance created as you can see in env

# resource "aws_instance" "name" {
#     ami = "ami-00ecbb8ba07f65d41"
#     instance_type = "t2.micro"
#     count = 2
#     # tags = {
#     #   Name = "dev"
#     # }
#   tags = {
#       Name = "dev-${count.index}"
#     }
# }

variable "env" {
    type = list(string)
    default = [ "test","main"]
  
}

resource "aws_instance" "name" {
    ami = "ami-00ecbb8ba07f65d41"
    instance_type = "t3.micro"
    count = length(var.env)
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = var.env[count.index]
    }
}
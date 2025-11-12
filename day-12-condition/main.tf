#CONDITION IS USED TO LIMIT THE REGION IF OUT RESOUECES IN US-EAST-1 AND IF BY MISTAKE ANY DEVLOPER CREATE RESOURCE
#IN ANOTHER REGION CONDITION RESTRICTS THE DEVLOPER

variable "aws_region" {
  description = "The region in which to create the infrastructure"
  type        = string
  nullable    = false
  default     = "us-east-1" #here we need to define either us-west-1 or eu-west-2 if i give other region will get error 
  validation {
    condition = var.aws_region == "us-east-1" || var.aws_region == "eu-west-1"
    error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, eu-west-1"
  }
}

provider "aws" {
 region = "us-east-1"
  
   
 }

#  resource "aws_s3_bucket" "dev" {
#     bucket = "statefile-configuresss"
    
  
# }

#after run this will get error like The variable 'aws_region' must be one of the following regions: us-west-2,│ eu-west-1, so it will allow any one region defined above in conditin block



### Example-2
# variable "create_bucket" {
#   type    = bool
#   default = false
# }

# resource "aws_s3_bucket" "example" {
#   count  = var.create_bucket ? 1 : 0
#   bucket = "my-terraform-example"
# }

#bool (boliean) is used to chose the number if default is true instance create if false 1 
#as you can see in line 52 and 38

## Example-3
variable "environment" {
  type    = bool
  default = false
}

resource "aws_instance" "example" {
  count         = var.environment == "prod" ? 3 : 1
  ami           = "ami-00ecbb8ba07f65d41"
  instance_type = "t3.micro"

  tags = {
    Name = "example-${count.index}"
  }
}

#even f bool default is true or false only in instance is created if to change remove ==prof in count line 
#then true = 3    false= 1

# #In this case:
# #If var.environment == "prod" → count = 3
# #Else (like dev, qa, etc.) → count = 1
# #terraform apply -var="environment=dev"
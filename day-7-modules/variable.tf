variable "ami_id" {
    description = "passing ami"
    default ="" 
    type = string 
}


variable "type" {
    description = "passing instance type"
    default = ""
    type = string
}

variable "tags" {
    description = "tags for ec2 instance"
    default = {}
    type = map(string)
  
}
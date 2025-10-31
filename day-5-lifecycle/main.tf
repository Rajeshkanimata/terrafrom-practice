resource "aws_instance" "name" {
 ami = "ami-00ecbb8ba07f65d41"
 instance_type = "t3.micro"
 tags = {
   Name = "test"
 }


    # lifecycle {
    # create_before_destroy = true
     #}
    # lifecycle {
    #   ignore_changes = [tags,  ]
    # }
    # lifecycle {
    #   prevent_destroy = true
    #}
}

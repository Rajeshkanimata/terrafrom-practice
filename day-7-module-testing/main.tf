module "name" {
    source = "../day-7-modules"
    ami_id = "ami-00ecbb8ba07f65d41"
    type = "t3.micro"

    tags = {
        Name = "Test"
    }

}
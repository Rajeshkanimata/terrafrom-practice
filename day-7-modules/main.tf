resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.type
    tags = merge(
        {
            Name = "MyInstance"
        },
        var.tags
    )
}
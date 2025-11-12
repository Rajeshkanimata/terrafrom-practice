resource "aws_launch_template" "frontend" {
  name_prefix            = "frontend-launch-template-"
  image_id               = "ami-ID"
  instance_type          = "t3.micro"
  key_name               = "key"
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  # Attach the IAM instance profile (which includes your role)
  #this attach iam to launch
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  # Optional: only if you need startup script
  # user_data = base64encode(file("userdata/frontend.sh"))
}

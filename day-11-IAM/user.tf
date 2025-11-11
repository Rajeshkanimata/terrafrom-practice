# SAMPLE SYNTAX

# resource "aws_iam_user" "dev_user" {
#   name = "developer"
#   tags = {
#     Department = "DevOps"
#   }
# }

# resource "aws_iam_access_key" "dev_user_key" {
#   user = aws_iam_user.dev_user.name
# }

#user profile login

resource "aws_iam_user" "dev_user" {
  name = "developer"
}

resource "aws_iam_user_login_profile" "dev_user_login" {
  user                  = aws_iam_user.dev_user.name
  password              = "cloud123"        # see note about secrets below
  password_reset_required = true                      # user must change password on first login
}

# to get AWS account number and ID

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

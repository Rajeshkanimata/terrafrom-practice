# this is a custom made policy

resource "aws_iam_policy" "custom_s3_policy" {
  name        = "CustomS3BucketAccess"
  description = "Allow EC2 to access only a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::my-app-bucket",
          "arn:aws:s3:::my-app-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "custom_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.custom_s3_policy.arn
}


# for this to attch to a instance add this in instance block

# iam_instance_profile {
#   name = "existing-ec2-role-profile"
# }

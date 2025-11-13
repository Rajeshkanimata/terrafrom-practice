# Create an S3 bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

# Enable versioning (optional)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

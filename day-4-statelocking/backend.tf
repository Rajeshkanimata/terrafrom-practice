terraform {
  backend "s3" {
    bucket = "terraform-state-file-storage-test-rajesh"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}
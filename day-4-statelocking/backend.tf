terraform {
  backend "s3" {
    bucket = "terraform-state-file-storage-test-rajesh"
    key = "terraform.tfstate"
    use_lockfile = true
    region = "us-east-1"
  }
}
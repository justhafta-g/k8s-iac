#Create a bucket to store tfstate
#Comment backend section before first run, 
#uncomment when s3 bucket created and run terraform init one more time
terraform {
  backend "s3" {
    bucket = "k8s-iac-tfstate-435563"
    key = "global/s3/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tfstate_ver" {
  bucket = var.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

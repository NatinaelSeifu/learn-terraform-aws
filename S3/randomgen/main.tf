terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.20.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
   }
  }
}

provider "random" {

       }
provider "aws" {

       }
  resource "random_string" "bucket_name" {
  upper = false
  lower  = true
  special = false
  length  = 16
}
  resource "aws_s3_bucket" "s3bucket00" {
  bucket = random_string.bucket_name.result
  
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}
terraform {
  # cloud {
  #   organization = "Natinael"

  #   workspaces {
  #     name = "s3simple-workspace"
  #   }
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.20.0"
    }
  }
}

provider "aws" {

       }

  resource "aws_s3_bucket" "myterr-s3-bucket-00" {
  bucket = "myterr-s3-bucket-01"

}

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
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

provider "random" {}

provider "aws" {}

resource "random_string" "instance_name" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_instance" "terrafor_serv" {
  ami           = "ami-00a9282ce3b5ddfb1"
  instance_type = "t2.micro"
}


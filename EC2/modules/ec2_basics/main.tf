terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.20.0"
    }
 
  }
}



#provider "aws" {}


resource "aws_instance" "terrafor_serv" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.keypair01

   tags = {
    Name = var.instance_tag
  }
}
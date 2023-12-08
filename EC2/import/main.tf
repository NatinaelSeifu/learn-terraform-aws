terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.20.0"
    }
   
  }
}

provider "aws" {
  
}

  import {
        id = "i-052a8147fd985053e"

        to = aws_instance.example
  }
  


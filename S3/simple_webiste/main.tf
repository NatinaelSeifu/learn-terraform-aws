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

locals {
  website_files_location = var.path_location
  assets_path = var.assets_path
}

  resource "aws_s3_bucket" "myterr-s3-bucket-01" {
  bucket = var.bucket_name

   tags = {
    
   name = var.bucket_tag
  }
}

################################
#configure the bucket for website but not needed for cloudfront OAC
################################

resource "aws_s3_bucket_website_configuration" "static_web" {
  bucket = aws_s3_bucket.myterr-s3-bucket-01.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.myterr-s3-bucket-01.id
  content_type = "text/html"
  key    =  "index.html"
  source = "${local.website_files_location}/index.html"
  etag   = filemd5("${local.website_files_location}/index.html")
   lifecycle{
  replace_triggered_by = [ terraform_data.content_version ]
  ignore_changes = [ etag ]
}
}

#######################################
# uploading multiple files to s3 bucket for the website
#######################################

resource "aws_s3_object" "multiple_object" {
  bucket = aws_s3_bucket.myterr-s3-bucket-01.id
  content_type = "text/css"
  for_each = fileset(local.assets_path, "**")
  key    =  "social_icons/${each.value}"
  source = "${local.assets_path}/${each.value}"
  etag   = filemd5("${local.assets_path}/${each.value}")

  lifecycle{
  replace_triggered_by = [ terraform_data.content_version ]
  ignore_changes = [ etag ]
}
}


##########################################
# configure s3 bucket  policy to be accessed from cloudfront
##########################################

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = aws_s3_bucket.myterr-s3-bucket-01.id
  policy = <<BUCKET_POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "AllowCloudFrontServicePrincipalReadOnly",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudfront.amazonaws.com"
        },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${var.bucket_name}/*",
        "Condition": {
            "StringEquals": {
                "AWS:SourceArn": "arn:aws:cloudfront::${var.ACCOUNT_ID}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
            }
        }
    }
    ]
}

BUCKET_POLICY
}



resource "terraform_data" "content_version" {
  input = var.content_version
}
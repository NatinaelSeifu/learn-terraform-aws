locals {
  s3_origin_id = "myS3origin"
}

resource "aws_cloudfront_origin_access_control" "origin_control01" {
  name                              = aws_s3_bucket.myterr-s3-bucket-01.bucket_regional_domain_name
  //description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.myterr-s3-bucket-01.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin_control01.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  #comment             = "Some comment"
  default_root_object = "index.html"

  #logging_config {
  #  include_cookies = false
  #  bucket          = "mylogs.s3.amazonaws.com"
  #  prefix          = "myprefix"
  #}

  # aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }



  # Cache behavior with precedence 1

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Environment = "tf-distribution for s3"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
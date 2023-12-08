output "s3_domain" {
  value = aws_s3_bucket.myterr-s3-bucket-01.bucket_domain_name
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}
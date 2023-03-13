output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}

output "s3_bucket_web_id" {
  value = aws_s3_bucket.web.id
}
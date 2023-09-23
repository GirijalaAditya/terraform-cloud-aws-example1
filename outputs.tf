output "s3_bucket_id" {
  description = "S3 Bucket ID"
  value = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_arn" {
  description = "S3 Bucket ARN"
  value = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_domain_name" {
  description = "S3 Bucket Domain Name"
  value = aws_s3_bucket.s3_bucket.bucket_domain_name
}

output "s3_bucket_regional_domain_name" {
  description = "S3 Bucket Domain Regional Name"
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}

output "s3_bucket_region" {
  description = "S3 Bucket Region"
  value = aws_s3_bucket.s3_bucket.region
}
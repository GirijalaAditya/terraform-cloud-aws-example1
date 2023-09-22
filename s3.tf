resource "aws_s3_bucket" "s3_bucket" {
  bucket = "adityagbucket-${random_string.random_data.id}"
  tags = local.common_tags

  force_destroy = true
}

resource "aws_s3_bucket_versioning" "s3_bucket_vers" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket = aws_s3_bucket.s3_bucket.id
  index_document {
    suffix = "s3-websites-files/index.html"
  }
  error_document {
    key = "s3-websites-files/error.html"
  }
}
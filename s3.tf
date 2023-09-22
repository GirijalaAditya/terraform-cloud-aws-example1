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

resource "aws_s3_object" "s3_object_1" {
  bucket = aws_s3_bucket.s3_bucket.id
  key = "index.html"
  source = file("s3-website-files/index.html")
}

resource "aws_s3_object" "s3_object_2" {
  bucket = aws_s3_bucket.s3_bucket.id
  key = "error.html"
  source = file("s3-website-files/error.html")
}

resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket = aws_s3_bucket.s3_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}
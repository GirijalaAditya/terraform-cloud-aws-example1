resource "aws_s3_bucket" "s3_bucket" {
  bucket = "adityagbucket-${random_string.random_data.id}"
  tags = local.common_tags
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3_bucket.id
  block_public_policy = false
  block_public_acls = false
  ignore_public_acls = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "s3_bucket_vers" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "name" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
		    "${aws_s3_bucket.s3_bucket.arn}",
		    "${aws_s3_bucket.s3_bucket.arn}/*"
	    ]
    }
  ]
}
EOF
}



resource "aws_s3_object" "s3_object_1" {
  bucket = aws_s3_bucket.s3_bucket.id
  storage_class = "STANDARD"
  key = "index.html"
  source = "./files/index.html"
}

resource "aws_s3_object" "s3_object_2" {
  bucket = aws_s3_bucket.s3_bucket.id
  storage_class = "STANDARD"
  key = "error.html"
  source = "./files/error.html"
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
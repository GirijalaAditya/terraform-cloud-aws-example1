resource "aws_s3_bucket" "s3_bucket" {
  bucket = "adityagbucket-${random_string.random_data.id}"
  tags = local.common_tags
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3_bucket.id
  block_public_policy = false
  block_public_acls = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "s3_bucket_vers" {
  depends_on = [ aws_s3_bucket_public_access_block.s3_public_access ]
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  depends_on = [ aws_s3_bucket_versioning.s3_bucket_vers ]
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.allow_bucket_access.json
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": [
#         "s3:GetObject"
#       ],
#       "Resource": [
# 		    "${aws_s3_bucket.s3_bucket.arn}",
# 		    "${aws_s3_bucket.s3_bucket.arn}/*"
# 	    ]
#     }
#   ]
# }
# EOF
}

data "aws_iam_policy_document" "allow_bucket_access" {
  statement {
    principals {
      type = "*"
      identifiers = [ "*" ]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      	"${aws_s3_bucket.s3_bucket.arn}",
	      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
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
  depends_on = [ 
    aws_s3_bucket.s3_bucket,
    aws_s3_bucket_versioning.s3_bucket_vers,
    aws_s3_object.s3_object_1,
    aws_s3_object.s3_object_2
   ]
  bucket = aws_s3_bucket.s3_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}
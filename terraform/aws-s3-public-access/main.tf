provider aws {
    region = "ap-south-1"
    access_key = "<ACCESS-KEY>"
    secret_key = "<SECRET-KEY>"
}

resource "aws_s3_bucket" "s3_bucket_example" {
  bucket = "<BUCKET-NAME>"
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls_example" {
  bucket = aws_s3_bucket.s3_bucket_example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block_example" {
  bucket = aws_s3_bucket.s3_bucket_example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl_example" {

  depends_on = [
    aws_s3_bucket_ownership_controls.ownership_controls_example,
    aws_s3_bucket_public_access_block.public_access_block_example,
  ]

  bucket = aws_s3_bucket.s3_bucket_example.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket_example.id
  policy = data.aws_iam_policy_document.allow_read_only_access.json
}


data "aws_iam_policy_document" "allow_read_only_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.s3_bucket_example.arn,
      "${aws_s3_bucket.s3_bucket_example.arn}/*",
    ]
  }
}
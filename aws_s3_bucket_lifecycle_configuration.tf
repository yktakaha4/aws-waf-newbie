resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.log.bucket

  rule {
    id     = "delete_logs"
    status = "Enabled"

    filter {
      prefix = "AWSLogs/"
    }

    expiration {
      days = 365
    }
  }
}

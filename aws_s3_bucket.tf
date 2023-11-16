resource "aws_s3_bucket" "log" {
  bucket = "${var.service}-log-${random_string.suffix.result}"
}

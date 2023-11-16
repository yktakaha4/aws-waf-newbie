resource "aws_lb" "main" {
  name               = "${var.service}-main"
  load_balancer_type = "application"

  internal = false

  security_groups = [
    aws_security_group.main.id,
  ]

  subnets = data.aws_subnets.default.ids

  access_logs {
    enabled = true
    bucket  = aws_s3_bucket.log.bucket
    prefix  = "alb/"
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.main_https.arn
  priority     = 1

  condition {}

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      status_code  = "200"
      message_body = templatefile(
        "${path.module}/templates/index.html",
        {
          title = "${var.service}-main-${random_string.suffix.result}"
        }
      )
    }
  }
}

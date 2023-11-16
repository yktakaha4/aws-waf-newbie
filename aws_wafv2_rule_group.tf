resource "aws_wafv2_rule_group" "custom" {
  name     = "${var.service}-custom"
  scope    = "REGIONAL"
  capacity = 200

  rule {
    name     = "${var.service}-custom-blocked-ip"
    priority = 0

    statement {
      or_statement {
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.blocked_ip_v4.arn
          }
        }

        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.blocked_ip_v6.arn
          }
        }
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.service}-custom-blocked-ip"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "${var.service}-custom-rate-limit"
    priority = 1

    statement {
      rate_based_statement {
        limit              = 100
        aggregate_key_type = "IP"

        scope_down_statement {
          regex_match_statement {
            regex_string = "^/brew/"

            field_to_match {
              uri_path {}
            }

            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
      }
    }

    action {
      block {
        custom_response {
          response_code = 429
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.service}-custom-rate-limit"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "${var.service}-brew-coffee"
    priority = 2

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.brew_coffee.arn

            field_to_match {
              body {
                oversize_handling = "CONTINUE"
              }
            }

            text_transformation {
              priority = 0
              type     = "URL_DECODE"
            }
          }
        }

        statement {
          regex_match_statement {
            regex_string = "^/brew/"

            field_to_match {
              uri_path {}
            }

            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }

        statement {
          byte_match_statement {
            search_string         = "POST"
            positional_constraint = "EXACTLY"

            field_to_match {
              method {}
            }

            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
      }
    }

    action {
      block {
        custom_response {
          response_code = 418
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.service}-brew-coffee"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.service}-custom"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl" "main" {
  name  = "${var.service}-main-${random_string.suffix.result}"
  scope = "REGIONAL"

  rule {
    name     = aws_wafv2_rule_group.custom.name
    priority = 0

    override_action {
      none {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.custom.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = aws_wafv2_rule_group.custom.name
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.service}-main-${random_string.suffix.result}"
    sampled_requests_enabled   = true
  }
}

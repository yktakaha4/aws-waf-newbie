resource "aws_wafv2_regex_pattern_set" "brew_coffee" {
  name  = "${var.service}-brew-coffee"
  scope = "REGIONAL"

  regular_expression {
    regex_string = "brew(\\s+|\\s+\\w+\\s+)coffee"
  }
}

resource "aws_wafv2_ip_set" "blocked_ip_v4" {
  name               = "${var.service}-blocked-ip-v4"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.blocked_ip_v4_addresses
}

resource "aws_wafv2_ip_set" "blocked_ip_v6" {
  name               = "${var.service}-blocked-ip-v6"
  scope              = "REGIONAL"
  ip_address_version = "IPV6"
  addresses          = var.blocked_ip_v6_addresses
}

variable "service" {
  default = "waf-newbie"
}

variable "blocked_ip_v4_addresses" {
  type    = list(string)
  default = []
}

variable "blocked_ip_v6_addresses" {
  type    = list(string)
  default = []
}

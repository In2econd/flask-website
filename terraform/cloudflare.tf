# Set in the terraform.tfvars file
variable "cloudflare_email" {}
variable "cloudflare_api_key" {}
variable "cloudflare_zone_id" {}
variable "load_balancer_ip" {}


# Configure Cloudflare Provider
provider "cloudflare" {
  version = "~> 2.0"
  email   = "${var.cloudflare_email}"
  api_key = "${var.cloudflare_api_key}"
}

# Configure DNS records
resource "cloudflare_record" "root" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "@"
  value   = "${var.load_balancer_ip}"
  type    = "A"
  ttl     = 1
  proxied = "true"
}

resource "cloudflare_record" "www" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "www"
  value   = "austinhervias.xyz"
  type    = "CNAME"
  ttl     = 1
  proxied = "true"
}
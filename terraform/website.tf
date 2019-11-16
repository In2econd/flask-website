# Set in the terraform.tfvars file
variable "do_token" {}

# Configure DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Configure droplet
resource "digitalocean_droplet" "webserver" {
  name   = "webserver"
  image  = "ubuntu-18-04-x64"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
}

# Configure firewall
resource "digitalocean_firewall" "website" {
  name = "website"

  droplet_ids = [digitalocean_droplet.webserver.id]

  inbound_rule {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
      protocol         = "icmp"
      source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Configure floating IP
resource "digitalocean_floating_ip" "website" {
  droplet_id = digitalocean_droplet.webserver.id
  region     = digitalocean_droplet.webserver.region
}

# Configure SSH key
# resource "digitalocean_ssh_key" "default" {
#   name       = "SSH key"
#   public_key = file("/path/to/.ssh/id_rsa.pub")
# }

# Set in the terraform.tfvars file
variable "cloudflare_email" {}
variable "cloudflare_api_key" {}
variable "cloudflare_zone_id" {}

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
  value   = digitalocean_floating_ip.website.ip_address
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

resource "cloudflare_record" "ssh" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "ssh"
  value   = "austinhervias.xyz"
  type    = "CNAME"
  ttl     = 1
  proxied = "false"
}
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
# flask-website
https://www.austinhervias.xyz
## Requirements
* Terraform
    * terraform.tf vars file
* DigitalOcean
    * Image with docker and fail2ban installed
* Cloudflare Account
* Datadog Account
* Docker (and Docker Hub account)
* Python 3.8
    * flask
## Infrastructure Layout
* GitHub
    * Docker Hub
        * Build image from master branch
    * Terraform
        * DigitalOcean
            * Droplet (Ubuntu)
                * Docker
                    * flask-website
                    * Portainer
                    * Datadog Agent
            * Firewall Rules
            * Floating IP
        * Cloudflare
            * DNS records
            * Datadog Metrics
## Setting up the environment
### Terraform
`terraform init`
`terraform plan` - Stage changes to infrastructure
`terraform apply` - Push changes to infrastructure
'terraform destroy` - Remove all DigitalOcean and Cloudflare infrastructure

### DigitalOcean
Log into droplet via SSH
Run shell/start_services.sh and install Datadog agent on docker
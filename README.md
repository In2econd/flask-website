# flask-website
https://www.austinhervias.xyz

![Docker Build Status](https://img.shields.io/docker/cloud/build/ahervias77/flask-website)
## Requirements
* Terraform
    * terraform.tfvars file
* DigitalOcean
    * Kubernetes cluster
* Cloudflare Account
* Docker (and Docker Hub account)
* Python 3.8
    * flask
## Infrastructure Layout
* GitHub
    * Docker Hub
        * Build image from master branch or tag
    * DigitalOcean
        * Kubernetes cluster
        * Load balancer
    * Terraform
        * Cloudflare
            * DNS records
    
## Setting up the environment
### DigitalOcean
Set up Kubernetes cluster

Create a deployment and expose it with a load balancer

Take note of the load balancer IP address and add it to the terraform.tfvars file

### Terraform
`terraform init`

`terraform plan` - Stage changes to Cloudflare infrastructure (DNS records)

`terraform apply` - Push changes to Cloudflare infrastructure

`terraform destroy` - Remove all Cloudflare infrastructure

### Updates
`kubectl scale deployments/flask-deployment --replicas=#` - Scale deployment to specified # of pods

`kubectl set image deployments/flask-deployment flask-website=flask-website:tag` - Rolling update

`kubectl rollout status deployments/flask-deployment` - Rollout status

`kubectl rollout undo deployments/flask-deployment` - Undo rolling update

## To Do
* Monitoring to replace Datadog
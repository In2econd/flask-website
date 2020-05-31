# flask-website
https://www.ahervias.dev

![Docker Build Status](https://img.shields.io/docker/cloud/build/ahervias77/flask-website)
![Website Status](https://img.shields.io/website?down_color=red&down_message=down&up_color=g&up_message=up&url=https%3A%2F%2Fwww.ahervias.dev)
## Requirements
* Terraform
    * terraform.tfvars file
* DigitalOcean
    * Kubernetes cluster
* Cloudflare Account
* Docker (and Docker Hub account)
* Python 3.8
    * flask
* LogDNA Account
* Datadog Account
## Infrastructure Layout
* GitHub
    * Docker Hub
        * Build image from tag
    * DigitalOcean
        * Kubernetes cluster
            * flask-website Deployment
            * LogDNA Agent
            * Datadog Agent
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

`kubectl set image deployments/flask-deployment flask-website=ahervias77/flask-website:tag` - Rolling update

`kubectl rollout status deployments/flask-deployment` - Rollout status

`kubectl rollout undo deployments/flask-deployment` - Undo rolling update

### Logging
LogDNA Agent v2 Setup: https://docs.logdna.com/docs/logdna-agent-kubernetes

Datadog: https://docs.datadoghq.com/agent/kubernetes/?tab=helm
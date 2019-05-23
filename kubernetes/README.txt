------------ README ------------

These example YAML files are to be used for deploying on Kubernetes.
They will pull the Docker Hub image associated with this repository and create a deployment.

To apply each of the configurations, run the following commands:

kubectl apply -f deploy.yml
kubectl apply -f expose.yml
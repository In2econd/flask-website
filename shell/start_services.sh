#!/bin/bash

docker run -d -p 80:80 --name flask-website ahervias77/flask-website
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name portainer -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

# Get Datadog docker agent on the Integrations/Agent page (contains API Key)
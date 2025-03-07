#!/bin/bash
# Pull the latest Docker image (if necessary)
docker pull webapp:latest

# Stop and remove any running container with the same name
docker stop webapp_container || true
docker rm webapp_container || true

# Run the Docker container
docker run -d --name webapp_container -p 80:80 webapp:latest


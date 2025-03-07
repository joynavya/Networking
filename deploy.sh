#!/bin/bash

# Load Image URI from the file
IMAGE_URI=$(cat /home/ubuntu/imageDetail.txt)

# Authenticate Docker to AWS ECR
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 888577039597.dkr.ecr.eu-west-1.amazonaws.com

# Stop and remove the existing container (if running)
docker stop webapp_container || true
docker rm webapp_container || true

# Pull the latest image from ECR
docker pull $IMAGE_URI

# Run the new container
docker run -d -p 80:80 --name webapp_container $IMAGE_URI

# Verify running container
docker ps


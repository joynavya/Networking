#!/bin/bash

# Extract information from imageDetail.txt
IMAGE_NAME=$(grep 'image_name' /home/ubuntu/webapp/imageDetail.txt | cut -d: -f2 | tr -d ' ')
IMAGE_VERSION=$(grep 'image_version' /home/ubuntu/webapp/imageDetail.txt | cut -d: -f2 | tr -d ' ')
CONTAINER_NAME=$(grep 'container_name' /home/ubuntu/webapp/imageDetail.txt | cut -d: -f2 | tr -d ' ')
PORT=$(grep 'port' /home/ubuntu/webapp/imageDetail.txt | cut -d: -f2 | tr -d ' ')

# Pull and run Docker container
docker pull $IMAGE_NAME:$IMAGE_VERSION
docker run -d --name $CONTAINER_NAME -p $PORT:80 $IMAGE_NAME:$IMAGE_VERSION

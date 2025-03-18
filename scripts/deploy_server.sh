#!/bin/bash

# Exit on error
set -e

# Configuration
EC2_INSTANCE_ID="YOUR_EC2_INSTANCE_ID"
EC2_REGION="YOUR_REGION"
EC2_USER="ec2-user"
SERVER_PORT=50051
DOCKER_IMAGE="chat-server:latest"

# Build the Docker image
echo "Building Docker image..."
docker build -t $DOCKER_IMAGE -f server/Dockerfile server/

# Save the Docker image
echo "Saving Docker image..."
docker save $DOCKER_IMAGE > chat-server.tar

# Copy the Docker image to EC2
echo "Copying Docker image to EC2..."
scp -i ~/.ssh/your-key.pem chat-server.tar $EC2_USER@$EC2_INSTANCE_ID:/home/$EC2_USER/

# SSH into EC2 and deploy
echo "Deploying to EC2..."
ssh -i ~/.ssh/your-key.pem $EC2_USER@$EC2_INSTANCE_ID << 'EOF'
  # Load the Docker image
  docker load < chat-server.tar

  # Stop and remove the old container
  docker stop chat-server || true
  docker rm chat-server || true

  # Run the new container
  docker run -d \
    --name chat-server \
    -p 50051:50051 \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    -e AWS_REGION=$AWS_REGION \
    chat-server:latest

  # Clean up
  rm chat-server.tar
EOF

# Clean up local files
rm chat-server.tar

echo "Deployment complete!" 
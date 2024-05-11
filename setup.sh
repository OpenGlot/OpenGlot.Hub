#!/bin/bash

# Update package lists
sudo yum update -y

# Install required packages
sudo yum install -y docker

# Start the Docker service
sudo service docker start

# Add the current user to the docker group (to avoid using sudo with docker commands)
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone the GitHub repository
git clone https://github.com/TotzkePaul/OpenGlot.Hub.git

# Change to the cloned repository directory
cd OpenGlot.Hub
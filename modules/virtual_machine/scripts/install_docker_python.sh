#!/bin/bash

# Update system packages
sudo apt-get update -y

# Install Python
sudo apt-get install -y python3 python3-pip

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce

# Enable Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Verify installations
python3 --version
docker --version

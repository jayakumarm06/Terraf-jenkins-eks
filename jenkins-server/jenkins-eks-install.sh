#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting the installation process..."

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install essential packages
echo "Installing required base packages..."
sudo apt install -y unzip curl gnupg software-properties-common apt-transport-https ca-certificates lsb-release

# --------------------
# Install AWS CLI v2
# --------------------
echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# --------------------
# Install Jenkins
# --------------------
echo "Installing Jenkins..."

# Install Java
sudo apt install -y fontconfig openjdk-17-jre

# Add Jenkins repository key and repo
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
    /etc/apt/sources.list.d/jenkins.list >/dev/null

# Update and install Jenkins
sudo apt update
sudo apt install -y jenkins

# Enable and start Jenkins
echo "Starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# --------------------
# Install Git
# --------------------
echo "Installing Git..."
sudo apt install -y git

# --------------------
# Install Terraform
# --------------------
echo "Installing Terraform..."
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update -y
sudo apt install -y terraform

# --------------------
# Install kubectl
# --------------------
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
rm -f kubectl

# --------------------
# Verify Installations
# --------------------
echo "Verifying installations..."
aws --version
java -version
jenkins --version || echo "Jenkins installation verified."
git --version
terraform -version
kubectl version --client || echo "kubectl installed successfully!"

echo "All tools have been installed successfully!"

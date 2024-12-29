#!/bin/bash

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Install curl if not already installed
sudo apt install curl -y

# Install NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \ . "$NVM_DIR/nvm.sh"  # Load NVM
  [ -s "$NVM_DIR/bash_completion" ] && \ . "$NVM_DIR/bash_completion"  # Load NVM bash_completion
else
  echo "NVM already installed."
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install Node.js version 18.18.2 and set as default
nvm install 18.18.2
nvm alias default 18.18.2
nvm use default

# Install PM2
npm install -g pm2

# Install Nginx
sudo apt install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Set up SSH keys for GitHub
SSH_KEY_FILE="$HOME/.ssh/github_ssh_key"
if [ ! -f "$SSH_KEY_FILE" ]; then
  echo "Setting up SSH keys for GitHub..."
  ssh-keygen -t ed25519 -C "6290.2020@students.ku.ac.ke" -f "$SSH_KEY_FILE" -N ""
  eval "$(ssh-agent -s)"
  ssh-add "$SSH_KEY_FILE"
else
  echo "SSH key already exists at $SSH_KEY_FILE."
fi

# Print the public key for GitHub setup
echo "Public key for GitHub setup:"
cat "$SSH_KEY_FILE.pub"

# Print versions to verify installation
echo "Node.js version: $(node -v)"
echo "NPM version: $(npm -v)"
echo "PM2 version: $(pm2 -v)"
echo "Nginx version: $(nginx -v)"

echo "Installation complete!"

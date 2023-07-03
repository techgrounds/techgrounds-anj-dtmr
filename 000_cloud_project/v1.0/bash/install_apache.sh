#!/bin/bash

echo "Setting up Apache web server"

# Update the system package list
sudo apt-get update

# Install Apache web server
sudo apt-get -y install apache2

# Allow Apache through the firewall
sudo ufw allow 'Apache'

# Start Apache service
sudo systemctl start apache2

# Enable Apache service to start at boot
sudo systemctl enable apache2

# Restart Apache
sudo systemctl restart apache2

# Wait for 5 seconds to let Apache restart before checking status
sleep 5

# Check the status of Apache service
sudo systemctl status apache2

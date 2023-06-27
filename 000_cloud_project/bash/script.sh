#!/bin/bash

echo ...
echo ...
echo getting Apache to you

# //------- get and install httpd
sudo apt-get update
sudo apt install apache2 -y

# //------- allow Apache to pass inner fw
ufw allow 'Apache'

# //-------- start service
sudo systemctl start apache2

# //-- enable httpd service to start at boot
sudo systemctl enable apache2

# //-- restart apache 
sudo systemctl restart apache2

# //-- wait 5 seconds to let apache2 restart and do the next step
sleep 5 

# //-- check status of apache service
sudo systemctl status apache2
#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
echo "<html><body><h1>Hello from Azure VMSS!</h1></body></html>" | sudo tee /var/www/html/index.html
sudo systemctl restart apache2

sudo ufw allow 80/tcp
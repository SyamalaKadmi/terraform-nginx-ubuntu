#!/bin/bash
apt update -y
apt install nginx -y
echo "Welcome to the Terraform-managed Nginx Server on Ubuntu" > /var/www/html/index.nginx-debian.html
systemctl start nginx

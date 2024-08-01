#!/bin/bash

# Variables
DOMAIN="yourdomain.com"
EMAIL="youremail@example.com"
WEBROOT="/var/www/html"

# Function to check if Certbot is installed
check_certbot_installed() {
  if ! command -v certbot &> /dev/null
  then
    echo "Certbot could not be found, installing..."
    sudo apt update
    sudo apt install certbot python3-certbot-apache -y
  fi
}

# Function to obtain/renew SSL certificate
obtain_or_ssl_cert() {
  sudo certbot certonly --webroot -w $WEBROOT -d $DOMAIN --email $EMAIL --agree-tos --non-interactive --renew-by-default
}

# Function to reload Apache to apply new certificate
reload_apache() {
  sudo systemctl reload apache2
}

# Main script execution
main() {
  check_certbot_installed
  obtain_or_ssl_cert
  reload_apache
}

main
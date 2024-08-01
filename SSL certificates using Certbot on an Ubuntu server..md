### Prerequisites

1. Install Certbot if you haven't already:
   ```bash
   sudo apt update
   sudo apt install certbot python3-certbot-apache
   ```

### Bash Script

Create a file named `ssl_cert.sh` and make it executable:

```bash
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
```

### Make the Script Executable

```bash
chmod +x ssl_cert.sh
```

### Usage

Run the script manually:

```bash
./ssl_cert.sh
```

### Automate Renewal with Cron

To ensure your SSL certificates are renewed automatically, you can set up a cron job:

```bash
crontab -e
```

Add the following line to run the script every day at midnight (adjust the schedule as needed):

```bash
0 0 * * * /path/to/ssl_cert.sh >> /var/log/ssl_cert.log 2>&1
```

Replace `/path/to/ssl_cert.sh` with the actual path to your script. The output will be logged to `/var/log/ssl_cert.log`.
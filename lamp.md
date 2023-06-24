#!/bin/bash

apt install phpmyadmin php-mbstring php-gettext -y
apt install python-certbot-apache -y
certbot --apache -d DOMAIN.TLD -d www.DOMAIN.TLD 
# Set a corresponding TXT record in DNS zone

# Set DB credentials with PHPMyAdmin
# Set Apache virtual host

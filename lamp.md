#!/bin/bash

apt install phpmyadmin php-mbstring php-gettext -y
apt install python-certbot-apache -y
certbot --apache -d DOMAIN.TLD -d www.DOMAIN.TLD 


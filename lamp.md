#!/bin/bash

apt update -y
apt install phpmyadmin php-mbstring php-gettext -y
apt upgrade ufw sshguard unattended-upgrades wget curl git zip unzip tree -y
ufw --force enable
ufw allow 22,25,80,443

apt install lamp-server^ -y
a2enmod http2 deflate expires

cat <<-EOF >> "$HOME"/.profile
	set -x
	complete -r
	export web_application_root="/var/www/html"
	export -f full_apache_restart

	full_apache_restart() {
		find "$web_application_root"/* -type d -exec chmod 755 {} \+
		find "$web_application_root"/* -type f -exec chmod 644 {} \+
		chown -R www-data:www-data "$web_application_root"/
		systemctl restart apache*
	}
EOF
source "$HOME"/.profile 2>/dev/null

# Set DB credentials with PHPMyAdmin
# Set Apache virtual host
# Set SSL certificate

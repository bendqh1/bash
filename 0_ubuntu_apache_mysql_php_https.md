Create a Debian-Apache-MySQL-PHP-HTTPS version-agnostic environment-bootstrapper to host at least one web application.

## Background variables and functions for future comfortability

This file is comprised of two parts.

* The first part is a `cat` heredocument for `.profile` aimed to declare some global modes, variables and functions ("global" as to effect all shell sessions), which, from my experience, are harmless.
* The second part is a single `source` sourcing of `.profile`, to ensure that the changes will be effective immediately in the very first shell session and actually in **any** shell session.

```shell
#!/bin/bash

cat <<-EOF > "$HOME"/.profile

# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

set -x # Work in debug mode
complete -r # Prevent messy output from "programmable completion

export web_application_root="/var/www/html"
export preferred_database_management_program="phpmyadmin"

export -f go_to_web_application_root
export -f security_and_server_restart
export -f temporarily_manage_database_and_lock_it_again

go_to_web_application_root() {
	cd ${web_application_root}/
}

security_and_server_restart() {
	chown -R www-data:www-data "$web_application_root"
	find "$web_application_root"/* -type d -exec chmod 755 {} \+
	find "$web_application_root"/* -type f -exec chmod 644 {} \+
	chmod -R 000 "$web_application_root"/"$preferred_database_management_program" # Lock it for *temporarily_manage_database_and_lock_it_again* function
 	systemctl restart apache*
}

temporarily_manage_database_and_lock_it_again() {
	find "$web_application_root"/* -type d -exec chmod 755 {} \+
	find "$web_application_root"/* -type f -exec chmod 644 {} \+
	echo 'chmod -R 000 "$web_application_root"/"$preferred_database_management_program"' | at now + 1 hours
}
EOF

source "$HOME"/.profile 2>/dev/null
```

### functions

* The function `security_and_server_restart` repeats basic security directives that might have been mistakenly changed, then allows temporary management of MySQL database by a database management program as well as restarting the webserver.
* The function `temporarily_manage_database_and_lock_it_again` means Temporarily manage the database until it locks again by `security_and_server_restart()`.

## Basic application installation and/or configuration

```shell
#!/bin/bash

apt update -y
apt upgrade ufw sshguard unattended-upgrades at wget curl git zip unzip tree -y
ufw --force enable
ufw allow 22,25,80,443/tcp
ufw allow 22,25,80,443/udp
apt install lamp-server^
apt install gettext php-curl php-cli php-mysql php-mysqli php-zip php-json php-cgi php-gd php-mbstring php-phpseclib
sudo apt install -y certbot python3-certbot-apache
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

a2enmod http2 deflate expires # Activate Apache mods
systemctl restart apache2
```

The following program is comprised of three files and is aimed to be used on fresh Debian installations -- as a Debian-Apache-MySQL-PHP-HTTPS version-agnostic environment-bootstrapper to host at least one web application.

## File 1 -- Background variables and functions for future comfortability

This file is comprised of two parts.

* The first part is a `cat` heredocument for `.profile` aimed to declare some global modes, variables and functions ("global" as to effect all shell sessions), which, from my experience, are harmless.
* The second part is a single `source` sourcing of `.profile`, to ensure that the changes will be effective immediately in the very first shell session and actually in **any** shell session.

```shell
#!/bin/bash

cat <<-EOF >> "$HOME"/.profile
set -x
complete -r

export web_application_root="/var/www/html"
export preferred_database_management_program="phpmyadmin"

export -f go_to_web_application_root security_and_server_restart temporarily_manage_database_and_lock_it_again # Create execution shortcuts to the following functions:

go_to_web_application_root() {
	cd $web_application_root/
}

security_and_server_restart() {
	chown -R www-data:www-data "$web_application_root"/
	find "$web_application_root"/* -type d -exec chmod 755 {} \+
	find "$web_application_root"/* -type f -exec chmod 644 {} \+
	chmod -R 000 "$web_application_root"/"$preferred_database_management_program"/ # Lock it for *temporarily_manage_database_and_lock_it_again* function
 	systemctl restart apache*
}

temporarily_manage_database_and_lock_it_again() {
	chmod -R a-x,a=rX,u+w "$web_application_root"/"$preferred_database_management_program"/
	echo "chmod -R 000 "$web_application_root"/"$preferred_database_management_program"/" | at now + 1 hours
}
EOF

source "$HOME"/.profile 2>/dev/null
```

### File 1 modes

* The mode `set -x` means constant working in full debug mode.
* The mode `complete -r` means constant removal of messy output of programmable completion (by calling to functions, etc) common in full debug mode.

### File 1 variables

* The `web_application_root` variable's value reflects a user's preferred *Web Application Root* directory.
* The `preferred_database_management_program` variable's value reflects a user's preferred *Database Management Program* (such as *phpmyadmin*).

### File 1 functions

* The function `go_to_web_application_root` means something like "navigate to Web Application Root easy and fast".
* The function `security_and_server_restart` repeats basic security directives that might have been mistakenly changed, then allows temporary management of MySQL database by a database management program as well as restarting the webserver.
* The function `temporarily_manage_database_and_lock_it_again` means Temporarily manage the database until it locks again by `security_and_server_restart()`.

## File 2 -- Basic application installation and/or configuration

```shell
#!/bin/bash

apt update -y
apt upgrade ufw sshguard unattended-upgrades wget curl git zip unzip tree -y
ufw --force enable
ufw allow 22,25,80,443
apt install lamp-server^
apt install php-gd php-zip php-cli pho-json php-curl php-mysql php-mbstring php-gettext phpmyadmin
apt install python-certbot-apache
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

a2enmod http2 deflate expires # Activate Apache mods
```

## File 3 -- Create and enable a Apahce virtual host file

```shell
#!/bin/bash

## Input for data that will be used in the virtual host file ##

read -p domain_1
read -p domain_2
if [ "$domain_1" = "$domain_2" ]; then
echo $domain_2.
else
   echo Mismatch.
fi

### Creaate a virtual host file ###

cat <<-EOF > /etc/apache2/sites-available/$domain_2.conf
    <VirtualHost *:80>
        ServerAdmin admin@"$domain_2"
        ServerName ${domain_2}
        ServerAlias www.${domain_2}
        DocumentRoot $web_application_root/${domain_2}
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>
EOF

### Make a softlink from the virtual host to the file enabling it ### 

ln -sf /etc/apache2/sites-available/"$domain_2".conf /etc/apache2/sites-enabled/
```

## File 4 ## -- Final configurations

```shell
certbot --apache -d "$domain_2" -d www."$domain_2"
```

echo "Open PHPMyAdmin and create databases";

The following program is comprised of three files and is aimed to be used on fresh Debian installations -- as a Debian-Apache-MySQL-PHP-HTTPS version-agnostic environment-bootstrapper to host at least one web application.

## File 1

This file is comprised of two parts, each part contains fundamental installation and/or configuration commands.

* The first part is a `cat` heredocument for `.profile` aimed to declare some global modes, variables and functions ("global" as to effect all shell sessions), which, from my experience, are harmless.

* The second part is a "sourcing" of `.profile`, to ensure the changes will be effective in the very first shell session and also after every boot of Debian.

File 1 code is as follows (clarifications available below the code block).

```shell
#!/bin/bash

cat <<-EOF >> "$HOME"/.profile
set -x
complete -r

export web_application_root="/var/www/html"
export preferred_database_management_program="phpmyadmin"

export -f go_to_web_application_root server_and_security_restart temporarily_manage_database # Create execution shortcuts to the following functions:

go_to_web_application_root() {
	cd $web_application_root/
}

server_and_security_restart() {
	chown -R www-data:www-data "$web_application_root"/
	find "$web_application_root"/* -type d -exec chmod 755 {} \+
	find "$web_application_root"/* -type f -exec chmod 644 {} \+
	systemctl restart apache*

	chmod -R 000 "$web_application_root"/"$preferred_database_management_program"/ # Lock it for *temporarily_manage_database* function
}
temporarily_manage_database() {
	chmod -R a-x,a=rX,u+w "$web_application_root"/"$preferred_database_management_program"/
	echo "chmod -R 000 "$web_application_root"/"$preferred_database_management_program"/" | at now + 1 hours
}
EOF

source "$HOME"/.profile 2>/dev/null
```

### File 1 modes

* The mode `set -x` means constant working in full debug mode
* The mode `complete -r` means constant removal of messy output of programmable completion (by calling to functions, etc) common in full debug mode

### File 1 variables

* The `web_application_root` variable's value reflects a user's preferred *Web Application Root* directory
* The `preferred_database_management_program` variable's value reflects a user's preferred *Database Management Program* (such as *phpmyadmin*)

### File 1 functions

* The function `go_to_web_application_root` means something like "navigate to Web Application Root easy and fast"
* The function `server_and_security_restart` repeats basic security directives that might have been mistakenly changed, then allows temporary management of MySQL database by a database management program as well as restarting the webserver
* The function `temporarily_manage_database` means *Temporarily Manage Database* and is useful after DB-manager security lock by `server_and_security_restart()`

## File 2

This file contains basic application installation and/or configuration commands.

```shell
#!/bin/bash

apt update -y
apt upgrade ufw sshguard unattended-upgrades wget curl git zip unzip tree -y
ufw --force enable
ufw allow 22,25,80,443
apt install lamp-server^
# apt install phpmyadmin php-mbstring php-gettext php-cli php-mysql # Do it with Composer?
apt install python-certbot-apache
certbot --apache -d DOMAIN.TLD -d www.DOMAIN.TLD 
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

a2enmod http2 deflate expires # Activate Apache mods
```

## File 3

This file uses to create an Apache virtual host and associated files.

This file should be executed only after creating a CMS-contexed database on top of MySQL program, based on a single pattern of data, **the web domain** which also uses as the name for:

* Web application DB user
* Web application DB instance
* Web application directory (explained in following chapter)

The file:

    #!/bin/bash
    
    read -p "Have you created db credentials already?" yn
    case $yn in
    	[Yy]* ) break;;
    	[Nn]* ) exit;;
    	* ) echo "Please create db credentials and then comeback;";;
    esac
    
    function read_and_verify  {
        read -p "$1:" tmp1
        read -p "$2:" tmp2
        if [ "$tmp1" != "$tmp2" ]; then
            echo "Values unmatched. Please try again."; return 2
        else
            read "$1" <<< "$tmp1"
        fi
    }
    
    read_and_verify domain "Please enter the domain of your web application twice" 
    read_and_verify dbrootp "Please enter the app DB root password twice" 
    read_and_verify dbuserp "Please enter the app DB user password twice"
    
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
    
    ln -sf /etc/apache2/sites-available/"$domain_2".conf /etc/apache2/sites-enabled/
    certbot --apache -d "$domain_2" -d www."$domain_2"

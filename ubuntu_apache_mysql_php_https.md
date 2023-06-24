The following program is comprised of three files and is aimed to be used on fresh Debian installations -- as a Debian-Apache-MySQL-PHP-HTTPS version-agnostic environment-bootstrapper to host at least one web application.

## File 1

This file is comprised of two parts, each part contains fundamental installation and/or configuration commands.

* The first part is a `cat` heredocument for `.profile` aimed to declare some global modes, variables and functions ("global" as to effect all shell sessions), which, from my experience, are harmless.

* The second part is a "sourcing" of `.profile`, to ensure the changes will be effective in the very first shell session and also after every boot of Debian.

File 1 code is as follows (clarifications available below the code block).

    #!/bin/bash
    
    cat <<-EOF >> "$HOME"/.profile
    	set -x
    	complete -r
    
    	export war="/var/www/html"
    	export dmp="phpminiadmin"
    
    	export -f war ssr tmd # Create execution shortcuts to the following functions:
    
    	war() {
    		cd $war/
    	}
    	
	ssr() {
		chown -R www-data:www-data "$war"/
		find "$war"/* -type d -exec chmod 755 {} \+
		find "$war"/* -type f -exec chmod 644 {} \+
		systemctl restart apache*
  
		chmod -R 000 "$war"/"$dmp"/
	}
    	tmd() {
    		chmod -R a-x,a=rX,u+w "$war"/"$dmp"/
    		echo "chmod -R 000 "$war"/"$dmp"/" | at now + 1 hours
    	}
    EOF
    
    source "$HOME"/.profile 2>/dev/null

### File 1 modes

* The mode `set -x` means constant working in full debug mode
* The mode `complete -r` means constant removal of messy output of programmable completion (by calling to functions, etc) common in full debug mode

### File 1 variables

* The `war` variable's value reflects a user's preferred *Web Application Root* directory
* The `dmp` variable's value reflects a user's preferred *Database Management Program* (such as *phpMiniAdmin*)

### File 1 functions

* The function `war` means something like "navigate to Web Application Root easy and fast"<br>
* The function `ssr` means **Secured Server Restart:**; that is, restart web server with repeating basic security directives that might have been mistakenly changed, as well as allowing temporary management of MySQL database by a database management program<br>
* The function `tmd` means *Temporarily Manage Database* and is useful after DB-manager security lock by `ssr()`

### File 2

This file contains basic application installation and/or configuration commands.

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

### File 3

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
    		DocumentRoot $war/${domain_2}
    		ErrorLog ${APACHE_LOG_DIR}/error.log
    		CustomLog ${APACHE_LOG_DIR}/access.log combined
    	</VirtualHost>
    EOF
    
    ln -sf /etc/apache2/sites-available/"$domain_2".conf /etc/apache2/sites-enabled/
    certbot --apache -d "$domain_2" -d www."$domain_2"

#!/bin/bash
cat <<-EOF >> "$HOME"/.profile
	set -x
	complete -r
	export web_application_root="/var/www/html"
	export -f web_application_root
	export -f full_apache_restart

	web_application_root() {
	  cd $web_application_root/
	}

	full_apache_restart() {
	  find "$web_application_root"/* -type d -exec chmod 755 {} \+
	  find "$web_application_root"/* -type f -exec chmod 644 {} \+
	  chown -R www-data:www-data "$web_application_root"/
	  systemctl restart apache*
	}
EOF
    
source "$HOME"/.profile 2>/dev/null

#!/bin/bash
apt update -y
apt upgrade ufw sshguard unattended-upgrades wget curl git zip unzip tree -y
ufw --force enable
ufw allow 22,25,80,443
apt install lamp-server^ python-certbot-apache
a2enmod http2 deflate expires

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

## Point Domain DNSs to your IaaS hosting provider
Just do it !

## Define a domain to work with

```shell
read domain_1 &&
read domain_2 &&
if [ "$domain_1" == "$domain_2" ]; then
echo $domain_2
else
   echo Mismatch.
fi
```

## Create a website basic filetree

```shell
mkdir ${web_application_root}/${domain_2}
```

## Use WinSCP to upload a file tree zip to the relevant directory and unzip it there

```shell
# WinSCP usage
cd ${web_application_root}/${domain_2}
unzip My_Zip_File
```

## Install and configure PHPMyAdmin

```shell
apt install phpmyadmin
mv /usr/share/phpmyadmin $web_application_root
apt install libapache2-mod-php
security_and_server_restart
temporarily_manage_database_and_lock_it_again

http://Server-IP/phpmyadmin

```

## Upload a database

Just do it !

## Create a Apahce virtual host file

```shell
#!/bin/bash
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
```

## Make a softlink from the virtual host file ⟶ to the file enabling it ##

```shell
ln -sf /etc/apache2/sites-available/"$domain_2".conf /etc/apache2/sites-enabled/
```

## Create a certification according to which the web application is TLS-secured

```shell
certbot --apache -d "$domain_2" -d www."$domain_2"
```

## Unset any variable used above

```shell
unset domain
```

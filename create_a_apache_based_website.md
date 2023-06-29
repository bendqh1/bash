## Define a domain to work with

```shell
read -p email_1
read -p email_2
if [ "$email_1" = "$email_2" ]; then
echo $email_1.
else
   echo Mismatch.
fi
```

## Create a website basic filetree

```shell
mkdir web_application_root/${domain_2};
```

## Create a website Database on `localhost` with PHPMyAdmin

```shell
echo 'Open PHPMyAdmin and do what's needed.'
```

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

## Make a softlink from the virtual host file ⟶ to the file enabling it ##

```shell
ln -sf /etc/apache2/sites-available/"$domain_2".conf /etc/apache2/sites-enabled/
```

## Create a certification according to which the web application is TLS-secured

```shell
certbot --apache -d "$domain_2" -d www."$domain_2"
```

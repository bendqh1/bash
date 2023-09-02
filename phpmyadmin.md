After installing PHPMyAdmin there are two ways to make it available from `IP_ADDRESS/phpmyadmin`.

## The common way

In `/etc/phpmyadmin/apache.conf` change:

```shell
Alias /phpmyadmin /usr/share/phpmyadmin
```

To:

```shell
Alias /phpmyadmin /var/www/html
```

## The uncommon way

Keep the default configuration and just make a symlink or soft link from

```shell
/usr/share/phpmyadmin
```

To:

```shell
/var/www/html/phpmyadmin
```

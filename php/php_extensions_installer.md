Inspect all PHP extensions

```shell
apt-cache pkgnames | grep php
```

Install at least one PHP extension

```shell
cat <<-EOF >/tmp/php_package_names.txt
   php-xml

EOF

cat /tmp/php_package_names.txt | while read line || [[ -n $line ]];
do
   apt install $line
done
```

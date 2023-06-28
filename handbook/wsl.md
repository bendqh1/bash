## Old versions

To delete a WSL version installed before the Windows store standard, go to either:

* Control panel > Uninstall a program
* Add or remove programs
* msconfig (services)
* Turn Windows features on or off

## Install a new version (Ubuntu)

Open CMD or PowerShell and run:

```shell
wsl --install
```

If you get the error:

> The requested operation requires elevation

Just re-run CMD as administrator.

## After:

* Reboot if needed
* apt update
* apt update

## Open current WSL directory from Windows explorer

```shell
explorer.exe .
```

## Debian/Ubuntu commands

```shell
sudo apt update
sudo apt install curl unzip
sudo apt install php php-curl
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer -V
```

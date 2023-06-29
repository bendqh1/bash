Create a new user, give it sudo privilage and change current user to it.

```shell
adduser sudoer
usermod -aG sudo
su - username
```

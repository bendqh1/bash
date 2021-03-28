```shell
sed -i
    '
        s/
            $to = ".*";$
        /
            $to = "'"$new_email_address"'";
        /g
    '
FILE_PATH
```

shell
```
sed -i \
    -e '/$to = ".*";$/!b' \
    -e "s//\$to = $q$new_email_address$q;/" \
FILE;
```

https://unix.stackexchange.com/questions/639222/how-to-break-sed-commands-to-nested-parts-in-a-bash-environment

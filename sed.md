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

https://unix.stackexchange.com/questions/639222/how-to-break-sed-commands-to-nested-parts-in-a-bash-environment

Secured mysqldump backup to home directory operation should be as follows.

## Background directives

    mkdir -p ${HOME}/backups_test/
    current_date="$(date +%d-%m-%Y-%H-%M-%S)"
    general_backups_dir="${HOME}/backups_test/"
    read -s dbname
    read -s dbusername

## mysqldump command:

    mysqldump -u"$dbusername" -p "$dbname" > "${general_backups_dir}/${dbusername}-${current_date}.sql"

Here is an example for a secured mysqldump backup to home directory.

## Background directives

    read -s db_name
    read -s db_nonroot_user_name
    current_date="$(date +%d-%m-%Y-%H-%M-%S)"
    general_backups_dir="${HOME}/backups_test/"

## Create the backup directory:

    mkdir -p ${HOME}/backups_test/

## Create the backup:

    mysqldump -u"$db_nonroot_user_name" -p "$db_name" > "${general_backups_dir}/${db_nonroot_user_name}-${current_date}.sql"

## Notes:

* Database Management Programs (i.e mysqldump, PHPMyAdmin) can produce databases in different sizes due to different data organization methods (as well as caching);

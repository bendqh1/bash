Secured mysqldump backup to home directory operation should be as follows.

## Background directives

    mkdir -p ${HOME}/backups_test/
    current_date="$(date +%d-%m-%Y-%H-%M-%S)"
    general_backups_dir="${HOME}/backups_test/"
    read -s db_name
    read -s db_nonroot_user_name

## mysqldump command:

    mysqldump -u"$db_nonroot_user_name" -p "$db_name" > "${general_backups_dir}/${db_nonroot_user_name}-${current_date}.sql"

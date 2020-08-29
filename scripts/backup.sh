#! /bin/bash

source ~/backup/scripts/vars.sh

is_dry_run=$1 # bool
date_time=$(/bin/date "+%m%d%Y%H%M%S")
log_file="${working_path}/log/rsync.${date_time}.txt"

# prepare the rsync command
command="rsync -Pav"
command="$command --exclude-from=${working_path}/exclude.lst"
command="$command --log-file=${log_file}"
command="$command --log-file-format='%n'"
command="$command --delete-before"
command="$command --delete-excluded"
command="$command --ignore-errors"

if ($is_dry_run); then
    # command is a dry run by default (true)
    command="$command --dry-run"
fi

command="$command /mnt/storage/* /mnt/usb-bak"

# run the rsync command targeting both backup drives
eval "${command}1/" > /dev/null 2>&1
eval "${command}2/" > /dev/null 2>&1

# return the path of the backup list file to stdout
echo $log_file

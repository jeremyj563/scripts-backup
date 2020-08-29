#! /bin/bash

source ~/scripts/vars.sh

is_dry_run=$1 # bool
date_time=$(/bin/date "+%m%d%Y%H%M%S")
log_file="${working_path}/log/rsync.${date_time}.txt"

# prepare the rsync command
command=( rsync -Pav )
command+=( --exclude-from=$working_path/exclude.lst )
command+=( --log-file=$log_file )
command+=( --log-file-format='%n' )
command+=( --delete-before )
command+=( --delete-excluded )
command+=( --ignore-errors )

if ($is_dry_run); then
    # command is a dry run by default (true)
    command+=( --dry-run )
fi

command+=( /mnt/storage/* /mnt/usb-bak)

# run the rsync command targeting both backup drives
"${command}1/" 2> /dev/null
"${command}2/" 2> /dev/null

# return the path of the backup list file to stdout
echo $log_file

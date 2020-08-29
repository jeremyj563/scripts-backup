# environment
me=$(basename "$0")
script_name=${me%.*}

# path
working_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
log_path=$working_path/log
log_archive_path=$log_path/archive

# log
log=$script_name.log
log_last_task=$script_name.lasttask.log
log_date=$(/bin/date -d "$(/usr/bin/stat -c %y "$log_path"/"$log")" '+%m-%d-%Y')

# exit
exit_code=0

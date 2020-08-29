#! /bin/bash

source ~/backup/scripts/vars.sh

is_dry_run=$1 # bool

# start backup procedure (--dry-run=true/false)
log_file="$(eval ${working_path}/backup.sh ${is_dry_run})"

# set the pending approval variable
eval "${working_path}/set_pending_approval.sh ${is_dry_run}"

if ($is_dry_run); then
    subject="Backup Approval Needed"
    body=" APPROVE: http://backup.jerlyd.com/true \n"
    body="$body DENY: http://backup.jerlyd.com/false"
else
    subject="Backup Results"
    body="Please see attachment for results"
fi

mail_to="modernclassicgamer@gmail.com"

# send the approval/results email with the files list attached
eval "${working_path}/send_email.sh '${mail_to}' '${subject}' '${log_file}' '${body}'"

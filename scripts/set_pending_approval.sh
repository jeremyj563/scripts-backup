#! /bin/bash

source ~/backup/scripts/vars.sh

status=$1

if [ "$status" == "true" ]; then
  echo "true" > $working_path/IS_APPROVAL_PENDING
else
  echo "false" > $working_path/IS_APPROVAL_PENDING
fi

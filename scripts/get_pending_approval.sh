#! /bin/bash

source vars.sh

pending_approval=$(head -n 1 $working_path/IS_APPROVAL_PENDING)

# only print to stdout if variable is not null or *whitespace*
if [ ! -z `echo $pending_approval` ]; then
  printf $pending_approval
fi

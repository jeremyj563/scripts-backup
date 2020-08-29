#! /bin/bash

mail_to=$1
subject=$2
attachment=$3
body=$4
email="to: ${mail_to}\nsubject: ${subject}\n\n${body}"

echo -e $email | (cat - && uuencode $attachment $attachment) | /usr/sbin/ssmtp $mail_to

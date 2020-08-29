#! /bin/bash

subject=$1
attachment=$2

mail_from="user@backup.jerlyd.com"
mail_to="modernclassicgamer@gmail.com"
date=$(/bin/date "+%m/%d%/Y %H:%M:%S")

body="<a href='http://backup.jerlyd.com:5000/true'>APPROVE</a>"
body="$body <a href='http://backup.jerlyd.com:5000/false'>DENY</a>"

email="From: ${mail_from}\n"
email="${email}To: ${mail_to}\n"
email="${email}Date: ${date}\n"
email="${email}Subject: ${subject}\n"
email="${email}MIME-Version: 1.0\n"
email="${email}Content-Type: multipart/mixed; boundary=012345\n\n--012345\n"
email="${email}Content-Type: text/html; charset=ISO-8859-1\n"
email="${email}Content-Transfer-Encoding: quoted-printable\n\n"
email="${email}${body}\n\n--012345\n"
email="${email}Content-Type: application/octet-stream; name=\"${attachment}\"\n"
email="${email}Content-Disposition: attachment; filename=\"${attachment}\"\n"
email="${email}X-Attachment-Id: file0\n\n\n"
email="${email}--012345--"

echo -e $email | /usr/sbin/ssmtp $mail_to
#echo -e $email | (cat - && uuencode $attachment $attachment) | /usr/sbin/ssmtp $mail_to

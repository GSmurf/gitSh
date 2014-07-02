#!/bin/sh

. ./sms_parametres.sh

date=`date`
message="Sms envoyé depuis mon Raspberry Pi le $date"

curl -s -i -k "https://smsapi.free-mobile.fr/sendmsg?user=$user&pass=$pass&msg=$message"

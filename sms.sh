#!/bin/sh

. ./sms_parametres.sh

d=`date`;
curl -s -i -k "https://smsapi.free-mobile.fr/sendmsg?user=$user&pass=$pass&msg=SMS envoyÃ©C depuis mon raspberry Pi ^^ $d"

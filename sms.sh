#!/bin/sh
d=`date`;
curl -s -i -k "https://smsapi.free-mobile.fr/sendmsg?user=13851267&pass=8oOMb5veBeyUUF&msg=SMS envoyé depuis mon raspberry Pi ^^ ${d}"

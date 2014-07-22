#!/bin/sh
nb=$(who | wc -l)
d=$(date '+%H:%M:%S')
l=$(tail -n 50 /var/log/apache2/access.log | grep -v 127.0.0 | awk '{print substr($4,14,length($4))}' | tail -n 1)

echo "apache : $l, date : $d"

if $l = '23:47:06' 
then
	echo "oui"
else
	echo "non"
fi

#!/bin/sh

. /home/pi/gitSh/sms_parametres.sh

date=$(date '+%A %d/%m/%Y à %H:%M:%S')
message="Sms envoyé depuis mon Raspberry Pi le $date"

# execute l'envoi de sms avec l'api de free
curl -s -i -k "https://smsapi.free-mobile.fr/sendmsg?user=$user&pass=$pass&msg=$message" > tmp.log

# recupere le code de retour de l'api
retour=$(cat tmp.log | grep HTTP/1.1 | awk '{print $2}')

if [ $retour != 200 ] 
then
	echo "erreur :"
	tmp.log >> /home/pi/logs/cron_sms.log
else
	echo "sms bien envoyé ;) avec les message : $message"
fi 

# suppression du fichier temp
rm tmp.log

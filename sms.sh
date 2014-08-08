#!/bin/bash

. /home/pi/gitSh/sms_parametres.sh

infoServeur=$(uptime)

# si le parametre 1 est --help alors affiche l'aide
if [ "$1" = "--help" ]
then
  echo "sms: Aide"
  echo "Saisissez « ./sms.sh 'Envoi du sms de test' » pour faire fonctionner ce script."
  exit
fi

# Utilise le parametre 1 comme message s'il est transmit
if [ $# = 1 ] 
then
  message="$1 $infoServeur"
else
  message="Sms automatique envoyé depuis mon Raspberry Pi le $infoServeur"
fi

# execute l'envoi de sms avec l'api de free
curl -s -i -k "https://smsapi.free-mobile.fr/sendmsg?user=$user&pass=$pass&msg=$message" > tmp.log

# recupere le code de retour de l'api
retour=$(cat tmp.log | grep HTTP/1.1 | awk '{print $2}')

if [ $retour != 200 ] 
then
	echo "erreur :"
	tmp.log >> /home/pi/logs/cron_sms.log
else
	echo "Sms envoyé, avec le message : $message"
fi 

# suppression du fichier temp
rm tmp.log


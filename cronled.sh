#!/bin/bash

# ------------------------------------------------
# Initialisation de variables
# ------------------------------------------------
fichierLog="/home/pi/logs/cron_led.log"
verte=0
rouge=2
jaune=1

# ------------------------------------------------
# Fonctions
# ------------------------------------------------
function initLed {
	for i in $verte $jaune $rouge
	do	
	  sudo gpio mode $i out
	done
}

function allumeLed {
  sudo gpio write $1 1
#  echo "led $1 allumée"
}

function eteindLed {
  sudo gpio write $1 0
#  echo "led $1 eteinte"
}

function eteindToutes {
  # eteindLed $verte
  eteindLed $jaune
  eteindLed $rouge
}

function allumeLedEteindAutres {
  for i in $1 $2
  do
    if [ $1 = $i ]
    then
      allumeLed $i
    else
      eteindLed $i
    fi
  done
}

# ------------------------------------------------
# Main
# ------------------------------------------------
# Initialise les diodes
initLed

date=$(date '+%Y-%m-%d %H:%M:%S')
# dateAvant=$(TZ='UTC-1:59' date '+%Y-%m-%d %H:%M:%S') # Heure il y a 1 minute
# t1=$(date --date="$dateAvant" +%s)
t2=$(date --date="$date" +%s)

# Combien de session SSh sont lancées
nb=$(who | wc -l) # who | grep -v 192.168.0. | wc -l (version qui ne provienne pas du reseau local)

# Recupere l'heure de la derniere connexion qui ne soit pas du à 127.0.0.1 sur les 50 derniers acces d'apache
lastConnexion=$(tail -n 50 /var/log/apache2/access.log | grep -v 127.0.0 | awk '{print $4 " " $5}' | tail -n 1)
t1=$(date --date="$lastConnexion" +%s)

let "diff=$t2-$t1"
if [ $diff -le "60" ] 
then 
	# il y a quelqu'un de connecté sur le serveur web
	allumeLed $verte
else
	eteindLed $verte
fi

if [ $nb -gt 0 ]
then
	if [ $nb = 1 ]
	then
		# si un utilisateur est connecté au ssh allume le gpio 1 (jaune)
		allumeLedEteindAutres $jaune $rouge
	else
		# si un utilisateur est connecté au ssh allume le gpio 2 (rouge)
		allumeLedEteindAutres $rouge $jaune
		echo "$date : $nb connexion(s) SSH, apache : $lastConnexion ($diff sec)" >> $fichierLog
		who >> $fichierLog
	fi
	else
		# Eteind tout si aucun des cas n'est présent
		eteindToutes
fi

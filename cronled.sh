#!/bin/sh

# Initialise les diodes
sudo gpio mode 0 out
sudo gpio mode 1 out
sudo gpio mode 2 out
sudo gpio write 1 0
sudo gpio write 2 0

nb=$(who | wc -l)
date=$(date '+%Y-%m-%d %H:%M:%S')


# Recupere l'heure de la derniere connexion qui ne soit pas du à 127.0.0.1 sur les 50 derniers acces d'apache
lastConnection=$(tail -n 50 /var/log/apache2/access.log | grep -v 127.0.0 | awk '{print substr($4,14,length($4))}' | tail -n 1)

case $nb in
  1)
	# si un utilisateur est connecté au ssh allume le gpio 2 (rouge) 
	sudo gpio write 1 1
	echo "$date : 1 connexion SSH, derniere connexion à apache : $lastConnection"
	;;
  2)
	# si un utilisateur est connecté au ssh allume le gpio 1 (jaune) 
	sudo gpio write 2 1
	echo "$date : 2 connexions SSH, derniere connexion à apache : $lastConnection"
	;;
  *)
	;;
esac

if [ $lastConnection = '11:27:58'] 
then 
	echo "oui" 
fi

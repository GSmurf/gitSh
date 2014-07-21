#!/bin/sh

# Initialise les diodes
gpio mode 0 out
gpio mode 1 out
gpio mode 2 out
gpio write 1 0
gpio write 2 0


# si un utilisateur est connecté au ssh allume le gpio 2 (rouge) 
nb=$(who | wc -l)
echo il y à $nb connexions

if [ $nb = '2' ] 
then
  gpio write 2 1
elif [ $nb = '1' ]
then
  gpio write 1 1
else
  gpio write 1 0
  gpio write 2 0
fi

# si quelqu'un est sur le serveur apache allume le gpio 0 (vert) 



# un cron executera un script shell toutes les minutes qui parsera le log d'apache 
# et fera un who et avec les grep correct s'il trouve les bonnes valeut lancera la fonction gpio avec tel ou tel parametre
# ifconfig eth0 | awk '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {print substr($2,5,length($2))}'

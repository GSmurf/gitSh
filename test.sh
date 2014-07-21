#!/bin/sh

# si un utilisateur est connecté au ssh allume le gpio 2 (rouge) 
nb=$(who | wc -l)
echo il y à $nb connexions

if [ $nb = 2 ] 
then
  echo "2 connexions"
elif [ $nb = 1 ]
then
  echo "1 connexion"
else
  echo "autres connexions"
fi

echo Test avec case

case $nb in
  1)
	echo "1 connexion"
	;;
  2)
	echo "2 connexions"
	;;
  *)
	echo "X connexions"
	;;
esac

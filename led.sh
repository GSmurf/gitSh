#!/bin/bash
# Pars du status que la led est au debut et etteinte l'allume x sec le GPIO du parametre 1
# puis l'etteinds x sec du parametre 2 etc ...
# ------------------------------------------------
# Fonctions
# ------------------------------------------------
function initLed {
  sudo gpio mode $1 out
}

function allumeLed {
  sudo gpio write $1 1
#  echo "led $1 allumée"
}

function eteindLed {
  sudo gpio write $1 0
#  echo "led $1 eteinte"
}

# ------------------------------------------------
# Main
# ------------------------------------------------
# Si aucun paramètre n'est passé alors renvoi une erreur
if [ $# -lt 1 ] 
then
  echo "led: opérande manquant"
  echo 'Saisissez « /led.sh GPIO tempsAllumé  tempsEteind ... » pour faire fonctionner ce script.'
  exit
fi

# initialise la led avec le premier parametre
initLed $1

j=1
allume=false
for i in "$@"
do
 if [ $j != 1 ]
 then
   if [ $allume = false ]
   then
     # par du status que la led est au debut etteinte l'allume x sec du parametre 1
     allumeLed $1
     allume=true
     sleep $i
   else
     # puis l'etteinds x sec du parametre 2 etc ...
     eteindLed $1
     allume=false
     sleep $i
   fi
 fi
 j=j+1
done

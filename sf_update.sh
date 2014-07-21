#!/bin/sh
sudo chmod 775 ./app/cache * -R
sudo rm app/cache/dev -R
sudo php ../composer.phar install
sudo chmod 775 ./app/cache * -R
sudo chown www-data:www-data ./* -R
echo "----------------------------------------------------------------"
echo "affichage des requetes pouvant etre executees :"
php app/console doctrine:schema:update --dump-sql
echo "----------------------------------------------------------------"
echo "Veux tu executer ces requetes jeune padawan? (o/n)"
read yn
case $yn in
    o ) php app/console doctrine:schema:update --force;;
    n ) exit;;
    * ) echo "les choix possibles sont (o/n)";;
esac

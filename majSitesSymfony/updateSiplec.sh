#!/bin/sh
echo "Mise à jour Git :"
sudo git stash
sudo git pull
echo "----------------------------------------------------------------"
echo "Mise à jour des vendors :"
sudo chmod 775 ./app/cache * -R
sudo chown www-data:www-data ./* -R
php /var/www/html/composer.phar install
sudo chmod 775 ./app/cache * -R
sudo chown www-data:www-data ./* -R
echo "----------------------------------------------------------------"
echo "Vidage du cache et suppression du app_dev"
sudo rm app/cache/* -R
sudo rm web/app_dev.php
echo "----------------------------------------------------------------"
echo "Affichage des requetes pouvant etre executees :"
php app/console doctrine:schema:update --dump-sql
echo "----------------------------------------------------------------"
echo "Veux tu executer ces requetes jeune padawan? (o/n)"
read yn
case $yn in
    o ) php app/console doctrine:schema:update --force;;
    n ) exit;;
    * ) echo "les choix possibles sont (o/n)";;
esac

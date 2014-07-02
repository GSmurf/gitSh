#!/bin/sh
echo "Mise à jour Git :"
sudo git pull
echo "----------------------------------------------------------------"
echo "Mise à jour des vendors :"
sudo chmod 775 ./app/cache * -R
php /var/www/html/composer.phar install
sudo chmod 775 ./app/cache * -R
sudo chown www-data:www-data ./* -R
echo "----------------------------------------------------------------"
echo "Affichage des requetes pouvant etre executees :"
php app/console doctrine:schema:update --force

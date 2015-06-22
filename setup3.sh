#!/bin/bash
unzip /var/www/master.zip -d /var/www/
mv /var/www/master/ /var/www/websig
rm /var/www/websig/master.zip

cd /var/www/websig/
lizmap/install/set_rights.sh www-data www-data



php /var/www/websig/lizmap/install/installer.php





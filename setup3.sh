#!/bin/bash
unzip /var/www/master.zip -d /var/www/
mv /var/www/master/ /var/www/websig
rm /var/www/websig/master.zip

cd /var/www/websig/
lizmap/install/set_rights.sh www-data www-data

cd lizmap/var/config
cp lizmapConfig.ini.php.dist lizmapConfig.ini.php
cp localconfig.ini.php.dist localconfig.ini.php
cp profiles.ini.php.dist profiles.ini.php
cd ../../..

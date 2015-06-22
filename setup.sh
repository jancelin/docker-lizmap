#!/bin/bash


unzip /var/www/master.zip -d /var/www/
mv /var/www/lizmap-web-client-master/ /var/www/websig/
rm /var/www/master.zip

 chmod +x /var/www/websig/lizmap/install/set_rights.sh
 /var/www/websig/lizmap/install/set_rights.sh www-data www-data
 
 cd /var/www/websig/lizmap/var/config
cp lizmapConfig.ini.php.dist lizmapConfig.ini.php
cp localconfig.ini.php.dist localconfig.ini.php
cp profiles.ini.php.dist profiles.ini.php
cd ../../..
 
 php /var/www/websig/lizmap/install/installer.php

mkdir /home2  
rm /var/www/websig/lizmap/var/db/jauth.db /var/www/websig/lizmap/var/db/logs.db /var/www/websig/lizmap/var/config/lizmapConfig.ini.php /var/www/websig/lizmap/var/config/installer.ini.php /var/www/websig/lizmap/var/config/profiles.ini.php /var/www/websig/lizmap/var/config/localconfig.ini.php
touch /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php /home2/installer.ini.php /home2/profiles.ini.php /home2/localconfig.ini.php
ln -s /home2/jauth.db /var/www/websig/lizmap/var/db/jauth.db
ln -s /home2/logs.db /var/www/websig/lizmap/var/db/logs.db
ln -s /home2/lizmapConfig.ini.php /var/www/websig/lizmap/var/config/lizmapConfig.ini.php
ln -s /home2/installer.ini.php /var/www/websig/lizmap/var/config/installer.ini.php
ln -s /home2/profiles.ini.php /var/www/websig/lizmap/var/config/profiles.ini.php
ln -s /home2/localconfig.ini.php /var/www/websig/lizmap/var/config/localconfig.ini.php

rm -R /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php /home2/installer.ini.php /home2/profiles.ini.php /home2/localconfig.ini.php 

sudo /var/www/websig/lizmap/install/set_rights.sh
sudo /var/www/websig/lizmap/install/clean_vartmp.sh

php /var/www/websig/lizmap/install/installer.php

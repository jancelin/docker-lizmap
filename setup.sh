#!/bin/sh
unzip /var/www/master.zip -d /var/www/
mv /var/www/master/ /var/www/websig
rm /var/www/websig/master.zip

cd /var/www/websig/
lizmap/install/set_rights.sh www-data www-data

mkdir /home2  

touch /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php /home2/installer.ini.php /home2/profiles.ini.php /home2/localconfig.ini.php
ln -s /home2/jauth.db /var/www/websig/lizmap/var/db/jauth.db
ln -s /home2/logs.db /var/www/websig/lizmap/var/db/logs.db
ln -s /home2/lizmapConfig.ini.php /var/www/websig/lizmap/var/config/lizmapConfig.ini.php
ln -s /home2/installer.ini.php /var/www/websig/lizmap/var/config/installer.ini.php
ln -s /home2/profiles.ini.php /var/www/websig/lizmap/var/config/profiles.ini.php
ln -s /home2/localconfig.ini.php /var/www/websig/lizmap/var/config/localconfig.ini.php

rm -R /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php /home2/installer.ini.php /home2/profiles.ini.php /home2/localconfig.ini.php 

php /var/www/websig/lizmap/install/installer.php

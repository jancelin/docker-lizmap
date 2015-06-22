#!/bin/bash
unzip /var/www/master.zip -d /var/www

rm /var/www/master.zip

chown -R :www-data /var/www/lizmap-web-client-master/temp/ \
    /var/www/lizmap-web-client-master/lizmap/var/ \
    /var/www/lizmap-web-client-master/lizmap/www \
    /var/www/lizmap-web-client-master/lizmap/install/qgis/edition/ 

chmod -R 775 /var/www/lizmap-web-client-master/temp/ \
    /var/www/lizmap-web-client-master/lizmap/var/ \
    /var/www/lizmap-web-client-master/lizmap/www \
    /var/www/lizmap-web-client-master/lizmap/install/qgis/edition/

rm -rf /var/www/lizmap-web-client-master/temp/lizmap/*

#dupliquer lizmap en plusieurs sites
cp -a /var/www/lizmap-web-client-master /var/www/websig
rm /var/www/websig/lizmap/var/jauth.db /var/www/websig/lizmap/var/logs.db /var/www/websig/lizmap/var/config/lizmapConfig.ini.php
mkdir /home2  
touch /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php
ln -s /home2/jauth.db /var/www/websig/lizmap/var/jauth.db
ln -s /home2/logs.db /var/www/websig/lizmap/var/logs.db
ln -s /home2/lizmapConfig.ini.php /var/www/websig/lizmap/var/config/lizmapConfig.ini.php
rm -R /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php 

#attribut les droit
chown :www-data /var/www/websig/temp/ /var/www/websig/lizmap/var/ /var/www/websig/lizmap/www /var/www/websig/lizmap/install/qgis/edition/ -R
chmod 775 /var/www/websig/temp/ /var/www/websig/lizmap/var/ /var/www/websig/lizmap/www /var/www/websig/lizmap/install/qgis/edition/ -R

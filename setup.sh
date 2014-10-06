#!/bin/bash
unzip /web/release_2_10.zip -d /web

rm /web/release_2_10.zip

chown -R :www-data /web/lizmap-web-client-release_2_10/temp/ \
    /web/lizmap-web-client-release_2_10/lizmap/var/ \
    /web/lizmap-web-client-release_2_10/lizmap/www \
    /web/lizmap-web-client-release_2_10/lizmap/install/qgis/edition/ 

chmod -R 775 /web/lizmap-web-client-release_2_10/temp/ \
    /web/lizmap-web-client-release_2_10/lizmap/var/ \
    /web/lizmap-web-client-release_2_10/lizmap/www \
    /web/lizmap-web-client-release_2_10/lizmap/install/qgis/edition/

rm -rf /web/lizmap-web-client-release_2_10/temp/lizmap/*

#dupliquer lizmap en plusieurs sites
cp -a /web/lizmap-web-client-release_2_10 /web/websig
rm /web/websig/lizmap/var/jauth.db /web/websig/lizmap/var/logs.db /web/websig/lizmap/var/config/lizmapConfig.ini.php
mkdir /home2  
touch /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php
ln -s /home2/jauth.db /web/websig/lizmap/var/jauth.db
ln -s /home2/logs.db /web/websig/lizmap/var/logs.db
ln -s /home2/lizmapConfig.ini.php /web/websig/lizmap/var/config/lizmapConfig.ini.php
rm -R /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php 

#attribut les droit
chown :www-data /web/websig/temp/ /web/websig/lizmap/var/ /web/websig/lizmap/www /web/websig/lizmap/install/qgis/edition/ -R
chmod 775 /web/websig/temp/ /web/websig/lizmap/var/ /web/websig/lizmap/www /web/websig/lizmap/install/qgis/edition/ -R


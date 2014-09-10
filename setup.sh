#!/bin/bash
unzip /web/2.10beta4.zip -d /web

rm /web/2.10beta4.zip

chown -R :www-data /web/lizmap-web-client-2.10beta4/temp/ \
    /web/lizmap-web-client-2.10beta4/lizmap/var/ \
    /web/lizmap-web-client-2.10beta4/lizmap/www \
    /web/lizmap-web-client-2.10beta4/lizmap/install/qgis/edition/ 

chmod -R 775 /web/lizmap-web-client-2.10beta4/temp/ \
    /web/lizmap-web-client-2.10beta4/lizmap/var/ \
    /web/lizmap-web-client-2.10beta4/lizmap/www \
    /web/lizmap-web-client-2.10beta4/lizmap/install/qgis/edition/

rm -rf /web/lizmap-web-client-2.10beta4/temp/lizmap/*

#dupliquer lizmap en plusieurs sites
cp -a /web/lizmap-web-client-2.10beta4 /web/websig
#RUN rm /web/websig/lizmap/var/jauth.db /web/websig/lizmap/var/logs.db /web/websig/lizmap/var/config/lizmapConfig.ini.php

mkdir /home2  
touch /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php
ln -s /home2/jauth.db /web/websig/lizmap/var/jauth.db
ln -s /home2/logs.db /web/websig/lizmap/var/logs.db
ln -s /home2/lizmapConfig.ini.php /web/websig/lizmap/var/config/lizmapConfig.ini.php
rm -R /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php 
#attribut les droit
chown :www-data /web/websig/temp/ /web/websig/lizmap/var/ /web/websig/lizmap/www /web/websig/lizmap/install/qgis/edition/ -R
chmod 775 /web/websig/temp/ /web/websig/lizmap/var/ /web/websig/lizmap/www /web/websig/lizmap/install/qgis/edition/ -R


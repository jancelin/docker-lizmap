#!/bin/bash
set -x 

mkdir /etc/apache2/ssl 
/usr/sbin/make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/apache2/ssl/apache.pem 
/usr/sbin/a2ensite default-ssl

mv /home/files/php.conf /etc/apache2/conf-available/php.conf
mv /home/files/apache2.conf /etc/apache2/apache2.conf 
rm -v /etc/apache2/mods-enabled/fcgid.conf
mv /home/files/fcgid.conf /etc/apache2/mods-enabled/fcgid.conf 
mv /home/files/mod_deflate.conf /etc/apache2/conf-available/mod_deflate.conf  
mv /home/files/apache_https.conf /etc/apache2/sites-available/default-ssl.conf 
mv /home/files/apache.conf /etc/apache2/sites-available/000-default.conf 
mv /home/files/index.html /var/www/index.html     
mv /home/files/start.sh /start.sh
chmod 0755 /start.sh

# unzip lizmap master
unzip /var/www/$LIZMAPVERSION.zip -d /var/www/
mv /var/www/lizmap-web-client-$LIZMAPVERSION/ /var/www/websig/
rm /var/www/$LIZMAPVERSION.zip
# Set rights & active config
chmod +x /var/www/websig/lizmap/install/set_rights.sh
/var/www/websig/lizmap/install/set_rights.sh www-data www-data
cp /home/files/lizmapConfig.ini.php /var/www/websig/lizmap/var/config/lizmapConfig.ini.php
cp /home/files/localconfig.ini.php /var/www/websig/lizmap/var/config/localconfig.ini.php
cp /var/www/websig/lizmap/var/config/profiles.ini.php.dist /var/www/websig/lizmap/var/config/profiles.ini.php
#cp /home/files/profiles.ini.php /var/www/websig/lizmap/var/config/profiles.ini.php
#  Installer
php /var/www/websig/lizmap/install/installer.php
#change jauth.db
#cp /home/files/jauth.db /var/www/websig/lizmap/var/db/jauth.db
# Set rights
chown :www-data  /var/www/websig/lizmap/www -R
chmod 775  /var/www/websig/lizmap/www -R
chown :www-data /var/www/websig/lizmap/var -R
chmod 775  /var/www/websig/lizmap/var -R
/var/www/websig/lizmap/install/set_rights.sh www-data www-data
cp -avr /var/www/websig/lizmap/var var/www/websig/lizmap/var_install

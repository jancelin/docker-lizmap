#!/bin/bash
set -x 

mkdir /etc/apache2/ssl 
/usr/sbin/make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/apache2/ssl/apache.pem 
/usr/sbin/a2ensite default-ssl

chmod 0755 /io/start.sh

# unzip lizmap master
tar xfz /var/www/$LIZMAPVERSION.tar.gz --strip-components=1 -C /var/www/
rm /var/www/$LIZMAPVERSION.tar.gz

# Set rights & active config
chmod +x /var/www/lizmap/install/set_rights.sh
/var/www/lizmap/install/set_rights.sh www-data www-data
cp /var/www/lizmap/var/config/profiles.ini.php.dist /var/www/lizmap/var/config/profiles.ini.php
#  Installer
php /var/www/lizmap/install/installer.php

#change jauth.db
#cp /home/files/jauth.db /var/www/lizmap/var/db/jauth.db
# Set rights
chown :www-data  /var/www/lizmap/www -R
chmod 775  /var/www/lizmap/www -R
chown :www-data /var/www/lizmap/var -R
chmod 775  /var/www/lizmap/var -R
/var/www/lizmap/install/set_rights.sh www-data www-data
cp -ar /var/www/lizmap/var var/www/lizmap/var_install && echo "done /var/www/lizmap/var var/www/lizmap/var_install"

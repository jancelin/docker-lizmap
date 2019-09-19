#!/bin/bash
set -e
#generate config file
VAR="/var/www/lizmap/var/config"

if [ ! -d $VAR ]; then
  echo "Creating Config file in /var"
  cp -avr /var/www/lizmap/var_install/*  /var/www/lizmap/var
fi

#set-rights
/var/www/lizmap/install/set_rights.sh www-data www-data

# Apache gets grumpy about PID files pre-existing
rm -f /run/apache2/apache2.pid

service php7.2-fpm start
/usr/sbin/apachectl start
certbot --non-interactive --apache --redirect --agree-tos --domains $LE_domain --email $LE_email
/usr/sbin/apachectl stop
sleep 5
exec /usr/sbin/apachectl -DFOREGROUND

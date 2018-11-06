#!/usr/bin/env bash

#generate config file

VAR="/var/www/websig/lizmap/var/config"

if [ ! -d $VAR ]; then
  echo "Creating Config file in /var"
  cp -avr /var/www/websig/lizmap/var_install/*  /var/www/websig/lizmap/var
fi
if [ ! -z "$POSTGRES_HOST" ]; then
#replace postgresql variables in profiles.ini.php for log and auth databases
  sed -i "s/###DB_HOST###/${POSTGRES_HOST}/; s/###DB_AUTH_NAME###/${POSTGRES_DB_AUTH_NAME}/; s/###DB_LOGS_NAME###/${POSTGRES_DB_LOGS_NAME}/; s/###DB_USER###/${POSTGRES_USER}/; s/###DB_PASSWORD###/${POSTGRES_PASS}/" /var/www/websig/lizmap/var/config/profiles.ini.php
else
  cp /var/www/websig/lizmap/var/config/profiles.ini.php.dist /var/www/websig/lizmap/var/config/profiles.ini.php
fi

#set-rights
  /var/www/websig/lizmap/install/set_rights.sh www-data www-data

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

exec /usr/sbin/apachectl -D FOREGROUND

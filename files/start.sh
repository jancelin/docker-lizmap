#!/bin/bash

#generate config file

VAR="/var/www/websig/lizmap/var/config"

if [ ! -d $VAR ]; then
  echo "Creating Config file in /var"
  cp -avr /var/www/websig/lizmap/var_install/*  /var/www/websig/lizmap/var
fi

#set-rights
  /var/www/websig/lizmap/install/set_rights.sh www-data www-data

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

exec /usr/sbin/apachectl -D FOREGROUND

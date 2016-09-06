#!/bin/bash

#generate config file

VAR="/var/www/websig/lizmap/var/config"

if [ ! -d $VAR ]; then
  echo "Creating Config file in /var"
  cp -avr /var/www/websig/lizmap/var_install/*  /var/www/websig/lizmap/var
fi

exec /usr/sbin/apachectl -D FOREGROUND

#!/bin/bash
set -e
#generate config file
VAR="/var/www/lizmap/var/config"

echo "LE_on:" $LE_on
echo "LE_staging:" $LE_staging
echo "LE_email:" $LE_email
echo "LE_domain:" $LE_domain


if [[ ! -d $VAR ]]; then
  echo "Creating Config file in /var"
  cp -avr /var/www/lizmap/var_install/*  /var/www/lizmap/var
fi

#set-rights
/var/www/lizmap/install/set_rights.sh www-data www-data

# Apache gets grumpy about PID files pre-existing
rm -f /run/apache2/apache2.pid

service php7.2-fpm start

if [[ $LE_on == 'true' ]]; then

	if [[ $LE_staging == 'true' ]]; then
       	echo "LE will use staging certificate"
    		STAGING='--test-cert'
	fi
	LE_CONF=/etc/apache2/sites-enabled/000-default-le-ssl.conf
	if [[ ! -f "$LE_CONF" ]]; then
    		/usr/sbin/apachectl start        
        echo "LE need to create conf files. Issuing:"
        set -x
        certbot --non-interactive --apache --redirect --agree-tos --domains $LE_domain --email $LE_email $STAGING
        set +x
   		/usr/sbin/apachectl stop
		sleep 5
	fi
fi
cron
exec /usr/sbin/apachectl -DFOREGROUND

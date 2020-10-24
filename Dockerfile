FROM ubuntu:bionic
MAINTAINER Marco Bernasocchi / docker-lizmap

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y universe \
    && add-apt-repository -y ppa:certbot/certbot

RUN apt-get -y update \
    && apt-get install -y --fix-missing python-simplejson xauth htop nano curl ntp ntpdate ssl-cert software-properties-common \
    apache2 libapache2-mod-fcgid \
    php7.2-fpm php7.2 \
    php7.2-curl php7.2-cli php7.2-sqlite php7.2-gd php7.2-pgsql php7.2-xmlrpc php7.2-xml php-ldap\
    sqlite3 postgresql-client \
    cron certbot python-certbot-apache

RUN apt-get clean \
    && rm -r /var/lib/apt/lists/*

ARG LE_domain="example.com"
ARG LE_email="info@example.com"
ARG LE_staging='true'
ARG LE_on='false'
ENV LE_domain=$LE_domain
ENV LE_email=$LE_email
ENV LE_staging=$LE_staging
ENV LE_on=$LE_on

# this can be overriden at build time with --build-arg lizmap_version=release_3_2
ARG lizmap_version=master
ENV LIZMAPVERSION=$lizmap_version

# setup apache modules
RUN a2dismod mpm_prefork mpm_event; \
    a2enmod actions alias ssl rewrite headers deflate mpm_worker; \
    a2enmod fcgid proxy_fcgi;

# copy config
COPY conf/apache2.conf /etc/apache2/
COPY conf/mod_deflate.conf /etc/apache2/conf-available/
COPY conf/fcgid.conf /etc/apache2/mods-enabled/
COPY conf/default-ssl.conf /etc/apache2/sites-available/
COPY conf/000-default.conf /etc/apache2/sites-available/
COPY conf/lizmapConfig.ini.php /var/www/lizmap/var/config/
COPY conf/localconfig.ini.php /var/www/lizmap/var/config/

# enable self signed SSL
RUN mkdir /etc/apache2/ssl
RUN make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/apache2/ssl/apache.pem
RUN a2ensite default-ssl

# install lizmap
RUN echo "Downloading https://github.com/opengisch/lizmap-web-client/archive/$LIZMAPVERSION.tar.gz"
RUN mkdir -p /var/www/ \
    && curl -SL https://github.com/opengisch/lizmap-web-client/archive/$LIZMAPVERSION.tar.gz \
    | tar --strip-components=1 -xzC /var/www
# Set rights & active config
RUN chmod +x /var/www/lizmap/install/set_rights.sh
RUN /var/www/lizmap/install/set_rights.sh www-data www-data
# use default profiles.ini
RUN cp /var/www/lizmap/var/config/profiles.ini.php.dist /var/www/lizmap/var/config/profiles.ini.php
#  Install
RUN rm -rf /var/www/temp/lizmap/*
RUN php /var/www/lizmap/install/installer.php
# backup default var folder
RUN cp -ar /var/www/lizmap/var var/www/lizmap/var_install

# change jauth.db
#COPY conf/jauth.db /var/www/lizmap/var/db/jauth.db

RUN mkdir -p /io/data/

VOLUME  ["/var/www/lizmap/var" , "/io"]
EXPOSE 80 443

# Add crontab file in the cron directory
ADD conf/crontab /etc/cron.d/cache-cron
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cache-cron
# Apply cron job
RUN crontab /etc/cron.d/cache-cron
# Create the log file to be able to run tail
RUN touch /var/log/cron.log


COPY conf/docker-entrypoint.sh /usr/local/bin/
#RUN chmod u+x /bin/docker-entrypoint.sh
CMD ["docker-entrypoint.sh"]

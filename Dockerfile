FROM ubuntu:bionic
MAINTAINER Marco Bernasocchi / docker-lizmap

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
    && apt-get install -y --fix-missing python-simplejson xauth htop nano curl ntp ntpdate ssl-cert software-properties-common \
    apache2 libapache2-mod-fcgid \
    php7.2-fpm php7.2 \
    php7.2-curl php7.2-cli php7.2-sqlite php7.2-gd php7.2-pgsql php7.2-xmlrpc php7.2-xml\
    sqlite3 postgresql-client \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

# this can be overriden at build time with --build-arg lizmap_version=release_3_2
ARG lizmap_version=master
ENV LIZMAPVERSION=$lizmap_version

# setup apache modules
RUN a2dismod mpm_prefork mpm_event; \
    a2enmod actions alias ssl rewrite headers deflate mpm_worker; \
    a2enmod fcgid proxy_fcgi;

# copy config
COPY files/apache2.conf /etc/apache2/
COPY files/mod_deflate.conf /etc/apache2/conf-available/
COPY files/fcgid.conf /etc/apache2/mods-enabled/
COPY files/default-ssl.conf /etc/apache2/sites-available/
COPY files/000-default.conf /etc/apache2/sites-available/
COPY files/lizmapConfig.ini.php /var/www/lizmap/var/config/
COPY files/localconfig.ini.php /var/www/lizmap/var/config/

# enable self signed SSL
RUN mkdir /etc/apache2/ssl
RUN make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/apache2/ssl/apache.pem
RUN a2ensite default-ssl

# install lizmap
RUN mkdir -p /var/www/ \
    && curl -SL https://github.com/opengisch/lizmap-web-client/archive/$LIZMAPVERSION.tar.gz \
    | tar --strip-components=1 -xzC /var/www
# Set rights & active config
RUN chmod +x /var/www/lizmap/install/set_rights.sh && /var/www/lizmap/install/set_rights.sh www-data www-data
# use default profiles.ini
RUN cp /var/www/lizmap/var/config/profiles.ini.php.dist /var/www/lizmap/var/config/profiles.ini.php
#  Install
RUN php /var/www/lizmap/install/installer.php
# backup default var folder
RUN cp -ar /var/www/lizmap/var var/www/lizmap/var_install

# change jauth.db
#COPY files/jauth.db /var/www/lizmap/var/db/jauth.db

RUN mkdir -p /io/qgis_projects/

VOLUME  ["/var/www/lizmap/var" , "/io"]
EXPOSE 80 443

COPY files/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
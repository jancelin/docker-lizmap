FROM ubuntu:22.04
LABEL opengisch.image.authors=="Clemens Rudert"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y universe
    # && add-apt-repository ppa:ondrej/php

RUN apt-get -y update \
    && apt-get install -y --fix-missing \
    python3-simplejson \
    xauth \
    htop \
    nano \
    curl \
    ntp \
    ntpdate \
    ssl-cert \
    openssl \
    software-properties-common \
    apache2 libapache2-mod-fcgid \
    php-fpm \
    php \
    php-curl \
    php-cli \
    php-pdo \
    php-pgsql \
    php-sqlite3 \
    php-gd \
    php-xmlrpc \
    php-xml \
    php-ldap\
    php-date \
    # php-zlib \
    sqlite3 \
    postgresql-client \
    cron certbot python3-certbot-apache \
    unzip \
    rsync \
    zlib1g

RUN apt-get clean \
    && rm -r /var/lib/apt/lists/*

# Get php composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php && \
    HASH=`curl -sS https://composer.github.io/installer.sig` && \
    echo $HASH && \
    php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

ARG LE_domain="example.com"
ARG LE_email="info@example.com"
ARG LE_staging='true'
ARG LE_on='false'

ENV LE_domain=$LE_domain
ENV LE_email=$LE_email
ENV LE_staging=$LE_staging
ENV LE_on=$LE_on

# this can be overriden at build time with --build-arg lizmap_version=release_3_2
ARG lizmap_version=3.6.7
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

# enable self signed SSL
RUN mkdir /etc/apache2/ssl
RUN make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/apache2/ssl/apache.pem
RUN a2ensite default-ssl

# install lizmap
RUN echo "Downloading https://github.com/3liz/lizmap-web-client/releases/download/$LIZMAPVERSION/lizmap-web-client-$LIZMAPVERSION.zip"
RUN mkdir -p /var/www/ \
    && curl -SL https://github.com/3liz/lizmap-web-client/releases/download/$LIZMAPVERSION/lizmap-web-client-$LIZMAPVERSION.zip > lizmap-web-client-$LIZMAPVERSION.zip && \
    unzip -q lizmap-web-client-$LIZMAPVERSION.zip && \
    rsync -a lizmap-web-client-$LIZMAPVERSION/* /var/www && \
    rm -rf lizmap-web-client-$LIZMAPVERSION && \
    rm -rf lizmap-web-client-$LIZMAPVERSION.zip
# set default configuration
RUN cp /var/www/lizmap/var/config/profiles.ini.php.dist /var/www/lizmap/var/config/profiles.ini.php
COPY conf/lizmapConfig.ini.php /var/www/lizmap/var/config/
COPY conf/localconfig.ini.php /var/www/lizmap/var/config/

# backup default var folder, it will be copied by docker-entrypoints.sh into /var/www/lizmap/var at first start,
# if the directory is empty
RUN mv /var/www/lizmap/var var/www/lizmap/var_install

# use default composer.json and install the extra modules
RUN cp /var/www/lizmap/my-packages/composer.json.dist /var/www/lizmap/my-packages/composer.json
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer require --working-dir=/var/www/lizmap/my-packages "jelix/saml-module"

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

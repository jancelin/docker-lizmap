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

# copy own scripts
COPY files/start.sh /io/
COPY files/setup.sh /io/

ADD https://github.com/opengisch/lizmap-web-client/archive/$LIZMAPVERSION.tar.gz /var/www/

RUN /io/setup.sh
    
VOLUME  ["/var/www/lizmap/var" , "/io"]
EXPOSE 80 443
ENTRYPOINT /io/start.sh

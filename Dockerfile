
FROM debian:stretch-slim
MAINTAINER Julien Ancelin / docker-lizmap 

RUN apt-get -y update \
    && apt-get -t stretch install -y  python-simplejson python-software-properties xauth htop vim curl ntp ntpdate ssl-cert\ 
    apache2 apache2-mpm-worker apache2-mpm-prefork apache2-bin apache2-data libapache2-mod-fcgid libapache2-mod-php7.0 \
    php7.0 php5-common php7.0-cgi php7.0-curl php7.0-cli php7.0-sqlite3 php7.0-xmlrpc php7.0-gd php7.0-pgsql unzip \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*
    
RUN a2dismod php7.0; a2enmod actions; a2enmod fcgid ; a2enmod ssl; a2enmod rewrite; a2enmod headers; \
    a2enmod deflate; a2enmod php7.0

ENV LIZMAPVERSION master

COPY files/ /home/files/

ADD https://github.com/3liz/lizmap-web-client/archive/$LIZMAPVERSION.zip /var/www/
RUN /home/files/setup.sh
    
VOLUME  ["/var/www/websig/lizmap/var" , "/home"] 
EXPOSE 80 443
CMD /start.sh


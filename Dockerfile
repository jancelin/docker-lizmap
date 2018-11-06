
FROM debian:jessie
MAINTAINER Gerald Salin / docker-lizmap 

RUN apt-get -y update \
    && apt-get -t jessie install -y  python-simplejson python-software-properties xauth htop vim curl ntp ntpdate ssl-cert\ 
    apache2 apache2-mpm-worker apache2-mpm-prefork apache2-bin apache2-data libapache2-mod-fcgid libapache2-mod-php5 \
    php5 php5-common php5-cgi php5-curl php5-cli php5-sqlite php5-gd php5-pgsql unzip\
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*
    
RUN a2dismod php5; a2enmod actions; a2enmod fcgid ; a2enmod ssl; a2enmod rewrite; a2enmod headers; \
    a2enmod deflate; a2enmod php5

ENV LIZMAPVERSION master
COPY files/ /home/files/

ADD https://github.com/3liz/lizmap-web-client/archive/$LIZMAPVERSION.zip /var/www/
RUN /home/files/setup.sh
    
VOLUME  ["/var/www/websig/lizmap/var" , "/home"] 
EXPOSE 80 443
CMD /start.sh

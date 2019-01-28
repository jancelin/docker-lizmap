
#Before crossbuild : docker run --rm --privileged multiarch/qemu-user-static:register --reset
# lancer le build: docker build  --network=host -t jancelin/geopoppy:lizmap_rpi3_3.2rc6 ./
FROM resin/raspberrypi3-debian:jessie
MAINTAINER Julien Ancelin / docker-lizmap 
RUN [ "cross-build-start" ]

RUN apt-get -y update \
    && apt-get -t jessie install -y  python-simplejson python-software-properties xauth htop vim curl ntp ntpdate ssl-cert\ 
    apache2 apache2-mpm-worker apache2-mpm-prefork apache2-bin apache2-data libapache2-mod-fcgid libapache2-mod-php5 \
    php5 php5-common php5-cgi php5-curl php5-cli php5-sqlite php5-gd php5-pgsql unzip\
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*
    
RUN a2dismod php5; a2enmod actions; a2enmod fcgid ; a2enmod ssl; a2enmod rewrite; a2enmod headers; \
    a2enmod deflate; a2enmod php5

#ENV LIZMAPVERSION 3.2rc6
ENV LIZMAPVERSION 3.2.1

COPY files/ /home/files/

ADD https://github.com/3liz/lizmap-web-client/archive/$LIZMAPVERSION.zip /var/www/
RUN /home/files/setup.sh
    
VOLUME  ["/var/www/websig/lizmap/var" , "/geopoppy"] 
EXPOSE 80 443
RUN [ "cross-build-end" ]
CMD /start.sh

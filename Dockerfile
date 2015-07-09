#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:14.04
MAINTAINER ancelin julien / docker-qgismapserver-lizmap
#RUN  export DEBIAN_FRONTEND=noninteractive
#ENV  DEBIAN_FRONTEND noninteractive
#RUN  dpkg-divert --local --rename --add /sbin/initctl

RUN echo "deb     http://qgis.org/debian-ltr trusty main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv DD45F6C3
RUN gpg --export --armor DD45F6C3 | apt-key add -

#ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

RUN apt-get -y update

#-------------Application Specific Stuff ----------------------------------------------------
#RUN echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu trusty main" >> /etc/apt/sources.list
#RUN gpg --keyserver keyserver.ubuntu.com --recv 314DF160 
#RUN gpg --export --armor 314DF160 | sudo apt-key add -

#RUN apt-get -y update

RUN apt-get install -y python-simplejson xauth htop nano curl ntp ntpdate python-software-properties git wget unzip \
    apache2 libapache2-mod-fcgid php5 php5-cgi php5-curl php5-cli php5-sqlite php5-gd php5-pgsql \
    libapache2-mod-php5 qgis-server apache2-mpm-prefork
RUN a2dismod php5; a2enmod actions; a2enmod fcgid ; a2enmod ssl; a2enmod rewrite; a2enmod headers; a2enmod deflate; a2enmod php5

#config compression
ADD mod_deflate.conf /etc/apache2/conf.d/mod_deflate.conf

#config php5
ADD php.conf /etc/apache2/conf.d/php.conf

# Remove the default mod_fcgid configuration file
RUN rm -v /etc/apache2/mods-enabled/fcgid.conf

# Copy a configuration file from the current directory
ADD fcgid.conf /etc/apache2/mods-enabled/fcgid.conf


EXPOSE 80
VOLUME /home
ADD apache2.conf /etc/apache2/apache2.conf
ADD apache.conf /etc/apache2/sites-available/000-default.conf
ADD apache.conf /etc/apache2/sites-enabled/000-default.conf
ADD fcgid.conf /etc/apache2/mods-available/fcgid.conf

# Set up the postgis services file
# On the client side when referencing postgis
# layers, simply refer to the database using
# Service: gis
# instead of filling in all the host etc details.
# In the container this service will connect 
# with no encryption for optimal performance
# on the client (i.e. your desktop) you should
# connect using a similar service file but with
# connection ssl option set to require

ADD pg_service.conf /etc/pg_service.conf
#USER www-data

# This is so the qgis mapserver uses the correct
# pg service file
ENV PGSERVICEFILE /etc/pg_service.conf

# install lizmap-web-client
#RUN mkdir /web
ADD https://github.com/3liz/lizmap-web-client/archive/master.zip /var/www/


RUN unzip /var/www/master.zip -d /var/www/
RUN mv /var/www/lizmap-web-client-master/ /var/www/websig/
RUN rm /var/www/master.zip

RUN  chmod +x /var/www/websig/lizmap/install/set_rights.sh
RUN /var/www/websig/lizmap/install/set_rights.sh www-data www-data
 
RUN cp /var/www/websig/lizmap/var/config/lizmapConfig.ini.php.dist /var/www/websig/lizmap/var/config/lizmapConfig.ini.php
RUN cp /var/www/websig/lizmap/var/config/localconfig.ini.php.dist /var/www/websig/lizmap/var/config/localconfig.ini.php
RUN cp /var/www/websig/lizmap/var/config/profiles.ini.php.dist /var/www/websig/lizmap/var/config/profiles.ini.php

RUN php /var/www/websig/lizmap/install/installer.php

RUN mkdir /home2  



#RUN rm /var/www/websig/lizmap/var/db/jauth.db /var/www/websig/lizmap/var/db/logs.db /var/www/websig/lizmap/var/config/lizmapConfig.ini.php /var/www/websig/lizmap/var/config/installer.ini.php  /var/www/websig/lizmap/var/config/localconfig.ini.php 
##/var/www/websig/lizmap/var/config/profiles.ini.php
#RUN touch /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php /home2/installer.ini.php /home2/localconfig.ini.php
##/home2/profiles.ini.php 
##
#RUN ln -s /home2/jauth.db /var/www/websig/lizmap/var/db/jauth.db
#RUN ln -s /home2/logs.db /var/www/websig/lizmap/var/db/logs.db
#RUN ln -s /home2/lizmapConfig.ini.php /var/www/websig/lizmap/var/config/lizmapConfig.ini.php
#RUN ln -s /home2/installer.ini.php /var/www/websig/lizmap/var/config/installer.ini.php
##RUN ln -s /home2/profiles.ini.php /var/www/websig/lizmap/var/config/profiles.ini.php
#RUN ln -s /home2/localconfig.ini.php /var/www/websig/lizmap/var/config/localconfig.ini.php
##
#RUN rm -R /home2/jauth.db /home2/logs.db /home2/lizmapConfig.ini.php /home2/installer.ini.php  /home2/localconfig.ini.php 
##/home2/profiles.ini.php
ADD mainconfig.ini.php /var/www/websig/lizmap/var/config/mainconfig.ini.php
RUN chown :www-data  /var/www/websig/lizmap/www -R
RUN chmod 775  /var/www/websig/lizmap/www -R


#RUN sudo /var/www/websig/lizmap/install/set_rights.sh
#RUN sudo /var/www/websig/lizmap/install/clean_vartmp.sh

#RUN php /var/www/websig/lizmap/install/installer.php
#ADD setup.sh /setup.sh
#RUN chmod +x /setup.sh
#RUN /setup.sh
VOLUME /home2
# Now launch apache in the foreground
CMD apachectl -D FOREGROUND

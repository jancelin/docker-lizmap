#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:14.04
MAINTAINER ancelin julien / docker-qgismapserver-lizmap
#RUN  export DEBIAN_FRONTEND=noninteractive
#ENV  DEBIAN_FRONTEND noninteractive
#RUN  dpkg-divert --local --rename --add /sbin/initctl

RUN echo "deb     http://qgis.org/debian trusty main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv DD45F6C3
RUN gpg --export --armor DD45F6C3 | apt-key add -

ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

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
ADD https://github.com/3liz/lizmap-web-client/archive/2.11.0.zip /var/www/

ADD setup.sh /setup.sh
RUN /setup.sh
VOLUME /home2
# Now launch apache in the foreground
CMD apachectl -D FOREGROUND

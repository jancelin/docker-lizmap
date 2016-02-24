#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:14.04
MAINTAINER ancelin julien / docker-qgismapserver-lizmap
RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl
# add qgis to sources.list
RUN echo "deb     http://qgis.org/debian-ltr trusty main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv DD45F6C3
RUN gpg --export --armor DD45F6C3 | apt-key add -
RUN apt-get -y update
#-------------Application Specific Stuff ----------------------------------------------------
RUN apt-get install -y python-simplejson xauth htop nano curl ntp ntpdate python-software-properties git wget unzip \
    apache2 libapache2-mod-fcgid php5 php5-cgi php5-curl php5-cli php5-sqlite php5-gd php5-pgsql \
    libapache2-mod-php5 qgis-server apache2-mpm-prefork --force-yes
RUN a2dismod php5; a2enmod actions; a2enmod fcgid ; a2enmod ssl; a2enmod rewrite; a2enmod headers; a2enmod deflate; a2enmod php5
#config compression
ADD mod_deflate.conf /etc/apache2/conf.d/mod_deflate.conf
#config php5
ADD php.conf /etc/apache2/conf.d/php.conf
# Remove the default mod_fcgid configuration file
RUN rm -v /etc/apache2/mods-enabled/fcgid.conf
# Copy a configuration file from the current directory
ADD fcgid.conf /etc/apache2/mods-enabled/fcgid.conf
# Open port 80 & mount /home 
EXPOSE 80
# Mount /home (persistent data)
VOLUME /home
ADD apache2.conf /etc/apache2/apache2.conf
ADD apache.conf /etc/apache2/sites-available/000-default.conf
ADD apache.conf /etc/apache2/sites-enabled/000-default.conf
ADD fcgid.conf /etc/apache2/mods-available/fcgid.conf
ADD pg_service.conf /etc/pg_service.conf
# pg service file
ENV PGSERVICEFILE /etc/pg_service.conf
#-----------------install lizmap-web-client-------------------------------
# Download & unzip
ADD https://github.com/3liz/lizmap-web-client/archive/master.zip /var/www/
# download setup.sh and play it for install lizmap3
ADD setup.sh /setup.sh
RUN chmod +x /setup.sh
RUN /setup.sh
# link volume lizmap_config persistent data host  if "-v /home/lizmap_var:/var/www/websig/lizmap/var" on docker run
VOLUME  /var/www/websig/lizmap/var
#add a redirection for just call the ip
ADD index.html /var/www/index.html
#rajoute nos projections perso à qgis-server
RUN wget https://github.com/jancelin/docker-lizmap/files/99407/srs.db.zip
RUN unzip srs.db.zip
RUN cp srs.db usr/share/qgis/resources/
# Now launch apache in the foreground
CMD apachectl -D FOREGROUND

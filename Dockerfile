FROM ubuntu:12.04
MAINTAINER Ancelin Julien 
ENV REFRESHED_AT 28-08-2014

# Install the relevant packages
RUN apt-get -yqq update && apt-get -yqq install python-simplejson xauth htop nano curl ntp ntpdate python-software-properties gitapache2 apache2-mpm-worker libapache2-mod-fcgid php5-cgi php5-curl php5-cli php5-sqlite php5-gd 
RUN a2dismod php5
RUN a2enmod actions
RUN a2enmod fcgid
RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod deflate

#config apache
ADD 

ADD apache-config.conf /etc/apache2/sites-enabled/000-default

# expose port 80 so that our webserver can respond to requests.
EXPOSE 80

# Manually set the apache environment variables in order to get apache to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

# Execute the apache daemon in the foreground so we can treat the container as an
# executeable and it wont immediately return.
ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]

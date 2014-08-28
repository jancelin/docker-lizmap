FROM ubuntu:12.04
MAINTAINER Ancelin Julien 
ENV REFRESHED_AT 28-08-2014

# Install the relevant packages
RUN apt-get -yqq update && apt-get -yqq install apache2 libapache2-mod-php5 php5-mysql

# Enable the php mod we just installed
RUN a2enmod php5
# Enable mod_rewrite
RUN a2enmod rewrite

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

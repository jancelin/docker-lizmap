docker-lizmap
=============

This image contains a WebGIS server: 
Apache, qgis-mapsever, lizmap-web-client, and all dependencies required for operation


To build the image do:

```
docker build -t jancelin/docker-websig git://github.com/jancelin/docker-websig
```

before running: 

This version keeps on host files (jauth.db, lizmapConfig.ini.php, logs.db) so you can use it for other Container. 

If the host is ubuntu server:
Copy the files to a directory on the host, do a chown www-data about each file and install php5-sqlite: apt-get install php5-sqlite

If the host is centos: Copy the files to a directory on the host, do a chown: 33 on each file (apache does not know :www-data, but :apache so we make it a joke). And install php5-sqlite: http://www.nginxtips.com/install-php-5-5-centos-6-5/


To run a container do:
```
docker run --name "websig-server" -p 8081:80 -d -t -v /your_qgis_folder:/home:ro -v /your_config_folder:/home2 jancelin/docker-websig
```

-p 8081:80 ---> link between the port 80 of the Container and port 8081 of the host

-v /your_folder:/home ---> provides a link between your host file (read-only)containing the .qgs, and / home Container.

-v /your_config_folder:/home2 ---> rovides a link between your host file containing the lizmap config, and / home2 Container.

ex: docker run --name "websig-server-entomo" -p 8081:80 -d -t -v /home/jancelin/ENTOMO:/home:ro -v /home/jancelin/sauvlizmap/entomo:/home2 jancelin/docker-websig




or for edit 

docker run  -i -t jancelin/docker-websig /bin/bash 

____________________________________________________________________________________

Lizmap working for testing at 

http://"your_ip_serveur":8081/lizmap-web-client-2.10beta4/lizmap/www/

lizmap admin at 

http://"your_ip_serveur":8081/lizmap-web-client-2.10beta4/lizmap/www/admin.php

Lizmap working with your data and config at : 

http://"your_ip_serveur":8081/websig/lizmap/www/

lizmap admin at 

http://"your_ip_serveur":8081/websig/lizmap/www/admin.php

____________________________________________________________________________________

Lizmap Web Application generates dynamically a web map application (php/html/css/js) with the help of Qgis Server ( QGIS Server Tutorial ). You can configure one web map per Qgis project with the QGIS LizMap Plugin.

http://docs.3liz.com/

http://www.3liz.com/

____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@stlaurent.lusignan.inra.fr) 09/2014 INRA

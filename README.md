docker-websig
=============

This image contains a WebGIS server: 
Apache, qgis-mapsever, lizmap-web-client, (owncloud) and all dependencies required for operation


To build the image do:

```
docker build -t jancelin/docker-websig git://github.com/jancelin/docker-websig
```
To run a container do:

docker run --name "websig-server" -p 8081:80 -d -t -v /your_folder:/home jancelin/docker-websig

or for edit 

docker run  -i -t jancelin/docker-websig /bin/bash 

____________________________________________________________________________________

Lizmap working at 

http://"your_ip_serveur":8081/lizmap-web-client-2.10beta4/lizmap/www/

lizmap admin at 

http://"your_ip_serveur":8081/lizmap-web-client-2.10beta4/lizmap/www/admin.php

____________________________________________________________________________________

More informations about lizmap

http://docs.3liz.com/

http://www.3liz.com/

____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@stlaurent.lusignan.inra.fr) 09/2014 INRA

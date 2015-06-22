
docker-lizmap 
=============

(lizmap-web-client-master and qgis-mapserver 2.8.1 inside)

![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/4627293/b7a0a594-5389-11e4-909b-916039a16981.png)


This image contains a WebGIS server: 
Apache, qgis-mapsever, lizmap-web-client, and all dependencies required for operation


1. To build the image do:

```
docker pull jancelin/docker-lizmap 
```
or alternatively, you can build an image from Github, we can see what happens during installation:

```
docker build -t jancelin/docker-lizmap git://github.com/jancelin/docker-lizmap
```

before running: 

This version keeps on host files (jauth.db, lizmapConfig.ini.php, logs.db) so you can use it for other Container.


2. Create two folders on /home (for exemple):
```
mkdir /home/lizmap_config

mkdir /home/lizmap_project
```


3. Copy config files from your old lizmap to your new config folder:
```
cp /var/www/websig/lizmap/var/jauth.db /home/lizmap_config/

cp/var/www/websig/lizmap/var/logs.db  /home/lizmap_config/

cp /var/www/websig/lizmap/var/config/lizmapConfig.ini.php /home/lizmap_config/
```
or download files if it's your first time with lizmap:

https://github.com/3liz/lizmap-web-client/blob/master/lizmap/var/jauth.db

https://github.com/3liz/lizmap-web-client/blob/master/lizmap/var/logs.db

https://github.com/3liz/lizmap-web-client/blob/master/lizmap/var/config/lizmapConfig.ini.php


4. Change permissions for docker read and write about the host:

If the host is ubuntu server:
Do a chown :www-data on each file ( or add -R for the folder)

If the host is centos or other: 
```
do a chown :33 on each file (ex: chown :33 -R /home/lizmap_config ).
```


5. Copy your qgis files and lizmap-plugin files to the second folder in your host:
```
cp ~/test.qgs /home/lizmap_project/

cp ~/test.qgs.cfg /home/lizmap_project/

cp ~/test.qgs.jpg /home/lizmap_project/
```
> (nb:
> I use a docker owncloud for synchronize files with my PC:

> docker build -t owncloud git://github.com/l3iggs/docker-owncloud

> And my qgis data come from a docker postgis:

> docker build -t kartoza/postgis git://github.com/kartoza/docker-postgis
> )

6. To run a container do:
```
docker run --restart="always" --name "websig-lizmap" -p 8081:80 -d -t -v /your_qgis_folder:/home:ro -v /your_config_folder:/home2 jancelin/docker-lizmap
```

* explanation about run

-p 8081:80 ---> link between the port 80 of the Container and port 8081 of the host.

 >  You can use 80:80 if it's the only service. 

 > You can use docker ngnix for do a proxy reverse and mapping in domaine or subdomain:
  
 > remplace -p 8081:80 by -e VIRTUAL_HOST=subdomain.domain.com
  
 > looking https://github.com/jancelin/nginx-proxy for more informations.
 
-v /your_folder:/home:ro ---> provides a link between your host file (read-only)containing the .qgs, and / home Container.

-v /your_config_folder:/home2 ---> provides a link between your host file containing the lizmap config, and / home2 Container.

ex: docker run --name "websig-lizmap-entomo" -p 8081:80 -d -t -v /home/jancelin/ENTOMO:/home:ro -v /home/jancelin/config/entomo:/home2 jancelin/docker-websig

7. Edit admin page in a browser for looking lizmap on the right qgis folder:
```
Open http://"your_ip_serveur":8081/lizmap-web-client-master/lizmap/www/admin.php

Go to "lizmap configuration"

change "Path to the local directory" to /home/
```
![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/7345155/66bd78cc-ecd2-11e4-987b-6788a104adb3.jpeg)

8. Try your project:

http://"your_ip_serveur":8081/websig/lizmap/www/

> exemple:
![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/7346841/96890bc4-ece2-11e4-82d7-d79d6f286aab.jpeg)

____________________________________________________________________________________

* for edit a container when it works

docker exec -it "id_or_name_container" bash 

* if you want to save your edition in a new image : 

docker commit "id_of_container" "new_image_name"

____________________________________________________________________________________

Lizmap working for testing at 

http://"your_ip_serveur":8081/lizmap-web-client-master/lizmap/www/

lizmap admin at 

http://"your_ip_serveur":8081/lizmap-web-client-master/lizmap/www/admin.php

Lizmap working with your data and config at : 

http://"your_ip_serveur":8081/websig/lizmap/www/

lizmap admin at 

http://"your_ip_serveur":8081/websig/lizmap/www/admin.php

____________________________________________________________________________________

Docker Commandes:

* docker pull jancelin/docker-lizmap --> build image from dockerhub.
* docker docker build -t jancelin/docker-lizmap git://github.com/jancelin/docker-lizmap --> build image from my repository.
* docker images --> show all images available on your docker
* docker rmi name_of_image --> delete image.
* docker run --restart="always" --name "websig-lizmap" -p 8081:80 -d -t -v /your_qgis_folder:/home:ro -v /your_config_folder:/home2 jancelin/docker-lizmap --> starting lizmap container
* docker ps -a --> list of all containers, who working and not.
* docker start name_container --> start container.
* docker stop name_container --> stopping container.
* docker rm name_container --> delete container (possibility to do : docker stop name_container && docker rm name_container)
* docker exec -it name_container bash --> go into the container with a session root shell and do anything.
* .... ---> https://docs.docker.com/userguide/
____________________________________________________________________________________

> example of server architecture

![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/7345474/3f403ca0-ecd5-11e4-8675-714fb9388863.jpg)

____________________________________________________________________________________

Lizmap Web Application generates dynamically a web map application (php/html/css/js) with the help of Qgis Server ( QGIS Server Tutorial ). You can configure one web map per Qgis project with the QGIS LizMap Plugin.

http://docs.3liz.com/

http://www.3liz.com/

![3_liz](http://www.3liz.com/assets/img/architecture.png)
____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@stlaurent.lusignan.inra.fr) 04/2015 INRA 

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Licence Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a>

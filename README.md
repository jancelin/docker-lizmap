

For testing, no persitent config data, working with lizmap-plugin-master:

```docker pull jancelin/docker-lizmap-master```

and running :

```docker run --restart="always" --name "lizmap3" -p 8081:80 -d -t -v /"your_.qgs_.cfg.qgs_folder":/home:ro jancelin/docker-lizmap-master```

ip:8081/websig/lizmap/www/admin.php

in admin lizmap : link folder /home/

look at:
ip:8081/websig/lizmap/www


=============

(lizmap-web-client-master and qgis-mapserver 2.8.1 inside)

![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/4627293/b7a0a594-5389-11e4-909b-916039a16981.png)


This image contains a WebGIS server: 
Apache, qgis-mapsever, lizmap-web-client, and all dependencies required for operation




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

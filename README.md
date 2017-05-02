docker-lizmap 
=============

(lizmap-web-client-3.1.1 and qgis-server LTR 2.14.x inside)

![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/4627293/b7a0a594-5389-11e4-909b-916039a16981.png)


This image contains a WebGIS server: 
Apache, qgis-mapsever, lizmap-web-client, and all dependencies required for operation


1. Before the first running :  

* Create folder for persistent data, config and cache
```
mkdir /home/lizmap_var
mkdir /home/lizmap_project 
mkdir /home/lizmap_tmp
chown :www-data -R /home/lizmap_tmp && chmod 775 -R /home/lizmap_tmp
```

* Copy files .qgs et .qgs.cfg in /home/lizmap_project (you can do after)


2. To build the image do :

```		
docker pull jancelin/docker-lizmap:3.1-2.14LTR
```		

* start container

 ``` 
 docker run --restart="always" --name "lizmap" -p 80:80 -d -t \
 -v /home/lizmap_project:/home \
 -v /home/lizmap_var:/var/www/websig/lizmap/var \
 -v /home/lizmap_tmp:/tmp \
 jancelin/docker-lizmap:3.1-2.14LTR
 ``` 

____________________________________________________________________________________

* If first install, config lizmap backoffice:

```
http://"ip"/websig/lizmap/www/admin.php
```

* Add **/home/** for looking your geo projects

![config](https://cloud.githubusercontent.com/assets/6421175/11306233/e945f342-8fb0-11e5-9906-4010b9398ef1.png)

* http://docs.3liz.com/fr/ 



=============


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

Lizmap Web Application generates dynamically a web map application (php/html/css/js) with the help of Qgis Server ( QGIS Server Tutorial ). You can configure one web map per Qgis project with the QGIS LizMap Plugin.

http://docs.3liz.com/

http://www.3liz.com/

![3_liz](http://www.3liz.com/assets/img/architecture.png)
____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@inra.fr) 2016 INRA 

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Licence Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a>

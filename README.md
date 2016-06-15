docker-lizmap 
=============

(lizmap-web-client-3.0.1 and qgis-server 2.14.3 inside)

![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/4627293/b7a0a594-5389-11e4-909b-916039a16981.png)


This image contains a WebGIS server: 
Apache, qgis-mapsever, lizmap-web-client, and all dependencies required for operation


1. To build the image do:

```		
docker pull jancelin/docker-lizmap 		
```		

 you can build an image from Github, we can see what happens during installation:

```
docker build -t jancelin/docker-lizmap git://github.com/jancelin/docker-lizmap
```

-----------------------------------------------------------------------------------

2. Before the first running :  

* Create folder for persistent data and config
```
mkdir /home/lizmap_var
mkdir /home/lizmap_project 
```

* set rights on lizmap_project

```
chown :www-data -R /home/lizmap_project
```

* Copy files .qgs et .qgs.cfg in /home/lizmap_project (you can do after)

* run a container with volume lizmap_var for copy /var/lizmap:
        
```
docker run --name "lizmap_temp" -p 8081:80 -d -t -v /home/lizmap_var:/home jancelin/docker-lizmap
```

* go into lizmap_temp container:

```docker exec -it lizmap_temp bash```

* Copy folders with rights lizmap/var:

```cp -avr /var/www/websig/lizmap/var/* /home/```

* exit container:

```exit ```

* On host, delete lizmap_temp

```docker stop lizmap_temp && docker rm lizmap_temp```

* start final container

 ``` docker run --restart="always" --name "lizmap" -p 80:80 -d -t -v /home/lizmap_project:/home -v /home/lizmap_var:/var/www/websig/lizmap/var jancelin/docker-lizmap ``` 

____________________________________________________________________________________

* Now config lizmap on web :

```
http://"ip"/websig/lizmap/www/admin.php
```

* Add **/home/** for looking your geo projects

![config](https://cloud.githubusercontent.com/assets/6421175/11306233/e945f342-8fb0-11e5-9906-4010b9398ef1.png)

* http://docs.3liz.com/fr/ 



=============


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

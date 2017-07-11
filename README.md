docker-lizmap 
=============

![docker_lizmap](https://cloud.githubusercontent.com/assets/6421175/25778701/68e9a536-3306-11e7-9196-84247b04eb92.png)
__________________________________________________________________

LizMap est une solution complète de publication de cartes QGIS sur Internet.

LizMap is a complete Internet QGIS map publishing.

____________________________________________________________________

Build image
-----------

* To build lizmap with Docker on a PC,server

```
docker build -t "lizmap" https://github.com/jancelin/docker-lizmap.git#3.1.1-0.1:/ -f Dockerfile
```

* To build lizmap with Docker on a Raspberry Pi

```
docker build -t "lizmap" https://github.com/jancelin/docker-lizmap.git#3.1.1-0.1:/ -f Dockerfile.raspberry
```

Or Pull from DockerHub
----------------------

* PC
```
docker pull jancelin/docker-lizmap:3.1.1-0.1
```

* Raspberry

```
docker pull jancelin/geopoppy:lizmap-3.1.1
```

With Docker-compose
-------------------

* Create folders for persistent data and config
```
mkdir /home/lizmap/lizmap_var
mkdir /home/lizmap/lizmap_project
mkdir /home/lizmap/tmp
chown :www-data -R /home/lizmap
```

* Create a docker-compose.yml for PC:

```
version: '2'
services:

#---Lizmap & Qgis-server-------------

  lizmap:
    image: jancelin/docker-lizmap:3.1.1-0.1
    restart: always
    ports:
     - 80:80
     - 443:443
    volumes:
     - /home/lizmap/lizmap_project :/home
     - /home/lizmap/lizmap_var:/var/www/websig/lizmap/var
     - /home/lizmap/tmp:/tmp
    links:
     - qgiserver:qgiserver

  qgiserver:
    image: jancelin/2.14LTR-wfsOutputExtension
    restart: always
    volumes:
      - /home/lizmap/project:/home
    expose:
      - 80
```

* Create a docker-compose.yml for Raspberry Pi


```
version: '2'
services:
#---WEBSIG-------------------------------------
  lizmap:
    image: jancelin/geopoppy:lizmap-3.1.1
    restart: always
    ports:
     - 80:80
     - 443:443
    volumes:
     - /home/lizmap/project:/home
     - /home/lizmap/project/var:/var/www/websig/lizmap/var
     - /home/lizmap/project/tmp:/tmp
    links:
     - qgiserver:qgiserver
##Change l'URL WMS in Lizmap back-office: http://qgiserver/cgi-bin/qgis_mapserv.fcgi

  qgiserver:
    image: jancelin/geopoppy:qgis-server2.14LTR-0.2
    restart: always
    volumes:
      - /home/lizmap/project:/home
    expose:
      - 80

```


* UP

```
docker-compose up -d
```

* Now config lizmap on web :

```
http://ip/websig/lizmap/www/admin.php
```
* change URL WMS: 

>> http://qgiserver/cgi-bin/qgis_mapserv.fcgi

* Add **/home/** for looking your geo projects

![config](https://cloud.githubusercontent.com/assets/6421175/11306233/e945f342-8fb0-11e5-9906-4010b9398ef1.png)

* http://docs.3liz.com/fr/ 


____________________________________________________________________________________

Lizmap working with your data and config at : 

```
http://"your_ip_rpi_wifi_serveur"
```
exemple for me: http://172.24.1.1

or
```
http://"your_ip_rpi_wifi_serveur"/websig/lizmap/www/
```
lizmap admin at 
```
http://"your_ip_rpi_wifi_serveur"/websig/lizmap/www/admin.php
```

Use https for the location

____________________________________________________________________________________

Lizmap Web Application generates dynamically a web map application (php/html/css/js) with the help of Qgis Server ( QGIS Server Tutorial ). You can configure one web map per Qgis project with the QGIS LizMap Plugin.

http://docs.3liz.com/

http://www.3liz.com/

____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@inra.fr) 2017

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Licence Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a>


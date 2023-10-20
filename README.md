[![Try in PWD](https://cdn.rawgit.com/play-with-docker/stacks/cff22438/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/jancelin/docker-lizmap/master/docker-compose.yml)

docker-lizmap 
=============

LizMap is a complete Internet QGIS map publishing.
___________________________________________________________________________

Building image:
---------------
docker build --build-arg lizmap_version=3.6.7 -t=opengisch/lizmap:3.6.7 .

Using image:
---------------

With Docker-compose:

* Create a docker-compose.yml and changing the directory path if necessary (home/lizmap/lizmap_project):

https://github.com/opengisch/docker-lizmap/blob/master/docker-compose.yml

* UP

```
docker-compose up -d
```

* Now config lizmap on web :

```
http://localhost/admin.php/config
```
* change URL WMS: 

>> http://qgiserver/cgi-bin/qgis_mapserv.fcgi

* Add **/io/qgis/** for looking your geo projects

![config](https://cloud.githubusercontent.com/assets/6421175/11306233/e945f342-8fb0-11e5-9906-4010b9398ef1.png)

* http://docs.3liz.com/fr/ 

-------------------------------

Lizmap Web Application generates dynamically a web map application (php/html/css/js) with the help of Qgis Server ( QGIS Server Tutorial ). You can configure one web map per Qgis project with the QGIS LizMap Plugin.

http://docs.3liz.com/

http://www.3liz.com/

____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@inra.fr) 2017

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Licence Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a>

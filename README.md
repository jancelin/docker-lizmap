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

Upgrading from Lizmap 3.5
-------------------------

If you want to reuse a database containing tables of Lizmap 3.5, create a directory somewhere,
for example `./lizmap-previous-config`, and copy these files into it:

- at least the `installer.ini.php` of the Lizmap 3.5 installation (stored originally into `lizmap/var/config`)
- the `lizmapConfig.ini.php` file if you want to retrieve the list of projects
- the `profiles.ini.php` file if there are specific connection profiles
- the `localconfig.ini.php` and `liveconfig.ini.php` if you want to retrieve some specific configuration, but
  you should remove from them any reference to modules that are not used anymore into your new lizmap container. 
- if you are using a sqlite database, the `jauth.db` database file (stored originally into `lizmap/var/db`)

Modify the `docker-compose.yml` file to mount the `./lizmap-previous-config` directory at `/var/www/lizmap/previous-config`
for the lizmap image. For example:

```
services:
  lizmap:
    ...
    volumes:
     - ./projects:/io/data:ro
     - var:/var/www/lizmap/var
     - ./lizmap-previous-config/:/var/www/lizmap/previous-config
```

Launch docker compose. It will install the `installer.ini.php` and the `jauth.db`, and other configuration files if
there are present, and then it will launch the Lizmap installer which will migrate data if needed.

Stop the containers and remove the mount on `/var/www/lizmap/previous-config`, else it will overwrite new data
at the next start, with the old database and old configuration files.



-------------------------------

Lizmap Web Application generates dynamically a web map application (php/html/css/js) with the help of Qgis Server ( QGIS Server Tutorial ). You can configure one web map per Qgis project with the QGIS LizMap Plugin.

http://docs.3liz.com/

http://www.3liz.com/

____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@inra.fr) 2017

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Licence Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a>

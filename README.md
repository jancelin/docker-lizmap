docker-websig
=============

This image contains a WebGIS server: 
Apache, qgis-mapsever, lizmap-web-client and all dependencies required for operation


To build the image do:

```
docker build -t jancelin/docker-websig git://github.com/jancelin/docker-websig
```
To run a container do:

docker run --name "websig-server" -p 8081:80 -d -t jancelin/docker-websig

or for edit 

docker run  -i -t jancelin/docker-websig /bin/bash

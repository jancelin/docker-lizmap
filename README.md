docker-websig
=============
To build the image do:

```
docker build -t jancelin/docker-websig git://github.com/jancelin/docker-websig
```
To run a container do:

This enables you to run this container as follows:

    sudo docker run -d -p 8003:80 -v /home/var/www:/var/www/my_website/public_html  --name websig -t jancelin/docker-websig


`<path_to_your_webapp>` is used as a volume. This is where your files should be (php-, html-, css-, js-files, etc). If your application needs write permission on some files or directories, you can change the owner (user and/or group) of those.

you could create a link to another container using `--link` (optional). e.g. a container hosting a DBMS (`--link database_container:db`)

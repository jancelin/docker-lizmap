docker-websig
=============
To build the image do:

docker build -t jancelin/docker-websig git://github.com/jancelin/docker-websig

To run a container do:

sudo docker run -d -p 80:80 -v <path_to_your_webapp>:/var/www/my_website/public_html --link <another_container>:<link_name> --name <container_name> -t <name_of_this_image>:<tag>

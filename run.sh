docker run --restart="always" --name="qgis-lizmap"  --hostname="qgis-lizmap" -p 8081:80  -d -t jancelin/docker-lizmap:3.1-2.14LTR
echo "Now point your browser at: http://localhost:8081/websig/lizmap/www/index.php"


```
docker exec disa_lizmap_1 sh -c "php /var/www/websig/lizmap/scripts/script.php lizmap~wmts:capabilities -v ortho orthochize"
docker exec disa_lizmap_1 sh -c "php /var/www/websig/lizmap/scripts/script.php lizmap~wmts:capabilities -v ortho orthochize ortho EPSG:2154 "
docker exec disa_lizmap_1 sh -c "php /var/www/websig/lizmap/scripts/script.php lizmap~wmts:seeding -v -f ortho orthochize ortho EPSG:2154 0 5"

```

;<?php die(''); ?>
;for security reasons , don't remove or modify the first line

; put here configuration variables that are specific to this installation


; chmod for files created by Lizmap and Jelix
;chmodFile=0664
;chmodDir=0775



[modules]
;; uncomment it if you want to use ldap for authentication
;; see documentation to complete the ldap configuration
;ldapdao.access=1


[coordplugin_auth]
;; uncomment it if you want to use ldap for authentication
;; see documentation to complete the ldap configuration
;driver=ldapdao
root@77ffb857c404:/var/www/websig/lizmap/var# cat ./config/lizmapConfig.ini.php
;<?php die(''); ?>
;for security reasons , don't remove or modify the first line

;Services
;list the different map services (servers, generic parameters, etc.)
[services]
wmsServerURL="http://qgiserverD/cgi-bin/qgis_mapserv.fcgi"
;List of URL available for the web client
onlyMaps=off
cacheStorageType=redis
;cacheStorageType=sqlite => store cached images in one sqlite file per repo/project/layer
;cacheStorageType=file => store cached images in one folder per repo/project/layer. The root folder is /tmp/
cacheRedisHost=redisD
cacheRedisPort=6379
cacheExpiration=0
; default cache expiration : the default time to live of data, in seconds.
; 0 means no expiration, max : 2592000 seconds (30 days)
proxyMethod=php
; php -> use the built in file_get_contents method
; curl-> use curl. It must be installed.
debugMode=1
; debug mode
; on = print debug messages in lizmap/var/log/messages.log
; off = no lizmap debug messages
cacheRootDirectory="/tmp/"
; cache root directory where cache files will be stored
; must be writable

; path to find repositories
; rootRepositories="path"
; Does the server use relative path from root folder? 0/1
; relativeWMSPath=0


appName=Lizmap
qgisServerVersion=2.18
wmsMaxWidth=3000
wmsMaxHeight=3000
relativeWMSPath=0
cacheRedisDb=1
cacheRedisKeyPrefix=a

[repository:demo]
label=Demo
path="/home/"
allowUserDefinedThemes=1

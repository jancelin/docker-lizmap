;<?php die(''); ?>
;for security reasons , don't remove or modify the first line

;Services
;list the different map services (servers, generic parameters, etc.)
[services]
wmsServerURL="http://qgiserver/cgi-bin/qgis_mapserv.fcgi"
;List of URL available for the web client

; cache
cacheStorageType=redis
;cacheStorageType=sqlite => store cached images in one sqlite file per repo/project/layer
;cacheStorageType=file => store cached images in one folder per repo/project/layer. The root folder is /tmp/
cacheRedisHost=redisD
cacheRedisPort=6379
cacheRedisDb=1
cacheRedisKeyPrefix=lm
cacheExpiration=0
; default cache expiration : the default time to live of data, in seconds.
; 0 means no expiration, max : 2592000 seconds (30 days)
cacheRootDirectory="/tmp"
; cache root directory where cache files will be stored. must be writable

proxyMethod=curl
; php -> use the built in file_get_contents method
; curl-> use curl. It must be installed.
debugMode=1
; debug mode
; on = print debug messages in lizmap/var/log/messages.log
; off = no lizmap debug messages

; path to find repositories
; rootRepositories="path"
; Does the server use relative path from root folder? 0/1
; relativeWMSPath=0


appName="Lizmap WebGIS"
qgisServerVersion=3.0
wmsMaxWidth=3000
wmsMaxHeight=3000
relativeWMSPath=0

onlyMaps=off
projectSwitcher=on
requestProxyEnabled=0
requestProxyType=http
requestProxyNotForDomain="localhost,127.0.0.1"
adminContactEmail="postmaster@localhost"
; googleAnalyticsID=UA-1234-1

[repository:demo]
label=Main
path="/io/qgis_projects/"
allowUserDefinedThemes=1

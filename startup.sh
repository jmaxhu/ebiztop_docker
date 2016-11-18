#!/bin/bash

# init mysql db structure is need
if [ ! -f /var/lib/mysql/ibdata1 ]; then

	mysql_install_db

fi

# start service
/usr/bin/supervisord

# start capture service use pm2
if [ -f /www/eBizTop/screenshot/index.js ]; then
	
	pm2 start /www/eBizTop/screenshot/index.js

fi
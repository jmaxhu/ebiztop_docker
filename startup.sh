#!/bin/bash

# start capture service use pm2
if [ -f /www/eBizTop/screenshot/index.js ]; then
	pm2 start /www/eBizTop/screenshot/index.js
fi

# start service
/usr/bin/supervisord


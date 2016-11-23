#!/bin/bash

tar czvf eBizTop.tar.gz --exclude 'eBizTop/web/node_modules' --exclude 'eBizTop/web/storage/logs' --exclude 'eBizTop/web/public/ebiztop.apk' --exclude 'eBizTop/web/public/temp' --exclude 'eBizTop/web/public/images/temp' --exclude 'eBizTop/web/.idea' --exclude 'eBizTop/web/.vscode' --exclude 'eBizTop/ui' --exclude 'eBizTop/app' --exclude 'eBizTop/.git' --exclude 'eBizTop/worker.log' /www/eBizTop

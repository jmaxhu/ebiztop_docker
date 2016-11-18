if [ ! -f /var/lib/mysql/ibdata1 ]; then

	mysql_install_db

	sleep 2s

  /usr/bin/supervisord
fi
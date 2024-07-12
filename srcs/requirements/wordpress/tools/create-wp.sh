#!/bin/sh

if [ -f ./wp-config.php ]; then
	echo "wordpress is already downloaded"
else

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	#Import env variables in the config file
	sed -i "s/username_here/$DB_USER_USERNAME/g" wp-config-sample.php
	sed -i "s/password_here/$DB_USER_PASS/g" wp-config-sample.php
	sed -i "s/localhost/$DB_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

fi

exec "$@"

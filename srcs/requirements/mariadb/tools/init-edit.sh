#! /bin/bash

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then

    service mariadb start
 
    ##################### CREATION USER, DATABASE  #####################
    # -e : Execute statement and quit.
    mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
 
    # MySQL's permissions are based on the host. When you CREATE USER (or GRANT) the user into existence, you provide a host name.
    # It can be '%' (wildcard) or 'localhost' or any other IP or hostname
    mysql -e "CREATE USER IF NOT EXISTS '${DB_USER_USERNAME}'@'%' IDENTIFIED BY '${DB_USER_PASS}';"
 
    mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_USERNAME}'@'%' IDENTIFIED BY '${DB_USER_PASS}';"
    mysql -e "FLUSH PRIVILEGES;"

    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"

    # To show host, user, password of all users:
	# mysql -u root -p${DB_ROOT_PASSWORD} -e "SELECT host, user, password FROM mysql.user;"
    
    sleep 3
	mysqladmin -u root -p${DB_ROOT_PASS} shutdown
fi

exec mysqld_safe #recommended way to start a mysqld server on Unix
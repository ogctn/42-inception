#!/bin/sh

if [ -f ./wp-config.php ]; then
	echo "wordpress is already downloaded"
else

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	cd /var/www/html

  	wp cli update
  	/usr/local/bin/wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER_USERNAME}" --dbpass="${DB_USER_PASS}" --dbhost="${DB_HOSTNAME}" --force --allow-root
  	/usr/local/bin/wp core install --allow-root --path=/var/www/html --url="https://${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_N}" --admin_password="${WP_ADMIN_P}" --admin_email="${WP_ADMIN_E}" --skip-email
  	/usr/local/bin/wp user create "${WP_U_NAME}" "${WP_U_EMAIL}" --role="${WP_U_ROLE}" --user_pass="${WP_U_PASS}" --allow-root

	wp config set WP_CACHE true --allow-root && \
	wp config set WP_REDIS_SELECTIVE_FLUSH true --allow-root && \
	wp config set WP_REDIS_DATABASE 0 --allow-root && \
	wp config set WP_REDIS_HOST redis --allow-root && \
	wp config set WP_REDIS_PORT 6379 --raw --allow-root && \
	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root && \
	wp config set WP_REDIS_CLIENT phpredis --allow-root && \
	wp plugin install redis-cache --activate --allow-root
fi
wp plugin update --all --allow-root && \
wp redis enable --allow-root

exec "$@"
#!/bin/sh

while ! wget --spider -q mariadb:3306; do
	echo "Waiting for db connection..."
	sleep 5
done

mkdir -p var/www/html/wordpress /run/php/
cd /var/www/html/
if [ ! -f "/var/www/html/.wordpress_installed" ]; then
	wp core download --allow-root
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=mariadb --path=/var/www/html/ --force
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --path=/var/www/html/ --allow-root
	wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD --path=/var/www/html/
	wp theme install fluida --activate --allow-root
	wp plugin update --all
	wp option update siteurl "https://$DOMAIN_NAME"
	wp option update home "https://$DOMAIN_NAME"
	touch /var/www/html/.wordpress_installed
else
	echo "Wordpress already setup"
fi

chown -R www:www /var/www/html
chown -R 775 /var/www/html

exec /usr/sbin/php-fpm81 -F

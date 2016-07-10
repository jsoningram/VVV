echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS ten"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON ten.* TO wp@localhost IDENTIFIED BY 'wp';"
if [ ! -d "wordpress/wp-admin" ]; then
	echo 'Installing WordPress (release version) in ten/wordpress...'
	if [ ! -d "./wordpress" ]; then
		mkdir ./wordpress
	fi
	cd ./wordpress
	wp core config --dbname="ten" --dbuser=wp --dbpass=wp --dbhost="localhost" --dbprefix=wp_ --allow-root --extra-php <<PHP
define('WP_DEBUG',          true);
define('WP_DEBUG_LOG',      true);
define('WP_DEBUG_DISPLAY',  true);
define('SCRIPT_DEBUG',      true);
define('SAVEQUERIES',       true);
PHP

	wp theme delete twentythirteen --allow-root; wp theme delete twentyfourteen --allow-root; wp theme delete twentyfifteen --allow-root; wp plugin delete hello --allow-root; wp plugin delete akismet --allow-root; git checkout HEAD .

	cd -

fi

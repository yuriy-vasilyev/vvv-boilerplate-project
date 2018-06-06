#!/usr/bin/env bash

# Add the site name to the hosts file
echo "127.0.0.1 ${VVV_SITE_NAME}.local # vvv-auto" >> "/etc/hosts"

# Make a database, if we don't already have one
echo -e "\nCreating database '${VVV_SITE_NAME}' (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS ${VVV_SITE_NAME}"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON ${VVV_SITE_NAME}.* TO wp@localhost IDENTIFIED BY 'wp';"
echo -e "\n DB operations done.\n\n"

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/log
touch ${VVV_PATH_TO_SITE}/log/error.log
touch ${VVV_PATH_TO_SITE}/log/access.log

# Install and configure the latest stable version of WordPress
mkdir -p ${VVV_PATH_TO_SITE}/public_html
cd ${VVV_PATH_TO_SITE}/public_html
if ! $(wp core is-installed --allow-root); then
  wp core download --allow-root
  wp core config --dbname="${VVV_SITE_NAME}" --dbuser=wp --dbpass=wp --quiet --allow-root --extra-php <<PHP
define( 'WP_POST_REVISIONS', false );

/** Enable debug tools */
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_DISPLAY', false );
define( 'WP_DEBUG_LOG', true );
define( 'SCRIPT_DEBUG', true );
define( 'JETPACK_DEV_DEBUG', true );
PHP
    wp core install --url=${VVV_SITE_NAME}.test --title="${VVV_SITE_NAME}" --admin_user=admin --admin_password=password --admin_email=admin@vvv.test --allow-root
else
  wp core update --allow-root
fi

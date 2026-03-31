#!/usr/bin/env bash
set -e

# We need to AllowOverride in /var/www/html for .htaccess directives
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/^[[:space:]]*AllowOverride[[:space:]]\+None/    AllowOverride All/' /etc/httpd/conf/httpd.conf
# Avoid using default privileged port
sed -i 's/^[[:space:]]*Listen[[:space:]]\+[0-9]\+/Listen 8080/' /etc/httpd/conf/httpd.conf

php-fpm -D
exec httpd -DFOREGROUND
#!/bin/sh
set -eu

CONFIG_DIR=/var/www/html/config-data
CONFIG_FILE="$CONFIG_DIR/config.inc.php"
mkdir -p "$CONFIG_DIR"

if [ ! -f "$CONFIG_FILE" ]; then
    cp /var/www/html/config.TEMPLATE.inc.php "$CONFIG_FILE"
    sed -i \
        -e "s|^base_url =.*|base_url = \"${OJS_BASE_URL:-http://localhost:8080}\"|" \
        -e "s|^installed =.*|installed = ${OJS_INSTALLED:-Off}|" \
        -e "s|^driver =.*|driver = ${DB_DRIVER:-mysqli}|" \
        -e "s|^host =.*|host = ${DB_HOST:-db}|" \
        -e "s|^username =.*|username = ${DB_USERNAME:-ojs}|" \
        -e "s|^password =.*|password = \"${DB_PASSWORD:-change-me}\"|" \
        -e "s|^name =.*|name = ${DB_DATABASE:-ojs}|" \
        -e "s|^files_dir =.*|files_dir = /var/www/html/files|" \
        "$CONFIG_FILE"
fi

ln -sfn "$CONFIG_FILE" /var/www/html/config.inc.php
mkdir -p /var/www/html/files /var/www/html/cache/t_compile /var/www/html/cache/_db
chown -R www-data:www-data /var/www/html/files /var/www/html/cache

exec "$@"

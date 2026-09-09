FROM composer:2 AS composer

FROM dunglas/frankenphp:1-php8.2-bookworm

RUN install-php-extensions gd intl mysqli pdo_mysql zip

WORKDIR /var/www/html
ENV SERVER_NAME=:80
ENV SERVER_ROOT=/var/www/html
COPY --chown=www-data:www-data . .
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY docker/entrypoint.sh /usr/local/bin/ojs-entrypoint
COPY Caddyfile /etc/frankenphp/Caddyfile

RUN composer install --working-dir=lib/pkp --no-dev --prefer-dist --no-interaction --no-progress \
    && mkdir -p files cache/t_compile cache/_db \
    && chmod +x /usr/local/bin/ojs-entrypoint \
    && chown -R www-data:www-data files cache

ENTRYPOINT ["ojs-entrypoint"]
CMD ["frankenphp", "run", "--config", "/etc/frankenphp/Caddyfile"]

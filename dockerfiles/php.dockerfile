FROM php:8.2-fpm-alpine as app

WORKDIR /var/www/html

RUN set -eux; \
    install-php-extensions pdo pdo_mysql;
FROM php:8.2-fpm-alpine as app

WORKDIR /var/www/html

RUN apk add --no-cache \
    git \
    make \
    unzip \
    && rm -rf /var/cache/apk/*

COPY src .

RUN docker-php-ext-install pdo pdo_mysql

RUN chown -R www-data:www-data /var/www/html


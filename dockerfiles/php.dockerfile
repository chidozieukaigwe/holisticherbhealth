FROM php:8.2-fpm-alpine AS app

WORKDIR /var/www/html

RUN apk add --no-cache \
    git \
    make \
    unzip \
    && rm -rf /var/cache/apk/*

#  @notes: we uncomment if we want composer installed into the container 

# ENV COMPOSER_ALLOW_SUPERUSER=1

# COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# COPY ./src/composer.* ./

# RUN composer install --ignore-platform-reqs  --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

COPY src .

RUN docker-php-ext-install pdo pdo_mysql

RUN chown -R www-data:www-data /var/www/html


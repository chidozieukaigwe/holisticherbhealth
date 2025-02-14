# FROM php:8.2-fpm-alpine AS app

# Use the ARM64-compatible Alpine Linux base image
FROM --platform=linux/arm64 alpine:3.18

WORKDIR /var/www/html

# Install system dependencies
# RUN apk update && apk add --no-cache \
#     git \
#     curl \
#     libpng-dev \
#     oniguruma-dev \ 
#     libxml2-dev \
#     zip \
#     unzip \
#     freetype-dev \
#     libjpeg-turbo-dev \
#     libwebp-dev \
#     zlib-dev \
#     dos2unix \
#     libzip-dev

RUN apk update && \
    apk add --no-cache \
        php82 \
        php82-common \
        php82-fpm \
        php82-opcache \
        php82-mysqli \
        php82-pdo \
        php82-pdo_mysql \
        php82-json \
        php82-openssl \
        php82-curl \
        php82-zlib \
        php82-xml \
        php82-phar \
        php82-tokenizer \
        php82-session \
        php82-mbstring \
        php82-gd \
        php82-iconv \
        php82-simplexml \
        php82-dom \
        php82-xmlreader \
        php82-xmlwriter \
        php82-fileinfo \
        php82-ctype \
        php82-sodium

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# Convert line endings and set execute permissions
RUN dos2unix /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY ./src/composer.* ./

COPY src .

RUN mv .env.example .env

RUN composer install --ignore-platform-reqs  --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

RUN composer dump-autoload

# Set permissions for Laravel storage and bootstrap cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

RUN chown -R www-data:www-data /var/www/html

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Start PHP-FPM
# CMD ["php-fpm"]

# Expose port 9000 for PHP-FPM
# EXPOSE 9000

# Start PHP-FPM - Start PHP in Foreground
CMD ["php-fpm82", "-F"]





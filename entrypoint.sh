#!/bin/sh
set -e

# This entrypoint script is to inject any and all env variables into the laravel .env file - DO NOT RUN LOCALLY

if [ "$APP_ENV" = "production" ] || [ "$APP_ENV" = "staging" ] || [ "$APP_ENV" = "testing" ]; then

# Path to the .env file
ENV_FILE="/var/www/html/.env"

# Update or add DB_PORT
if grep -q "^APP_NAME=" "$ENV_FILE"; then
    sed -i "s/^APP_NAME=.*/APP_NAME=${APP_NAME}/" "$ENV_FILE"
else
    echo "DB_HOST=${DB_HOST}" >> "$ENV_FILE"
fi

# Update or add DB_PORT
if grep -q "^APP_ENV=" "$ENV_FILE"; then
    sed -i "s/^APP_ENV=.*/APP_ENV=${APP_ENV}/" "$ENV_FILE"
else
    echo "DB_HOST=${DB_HOST}" >> "$ENV_FILE"
fi

# Update or add DB_PORT
if grep -q "^DB_PORT=" "$ENV_FILE"; then
    sed -i "s/^DB_PORT=.*/DB_PORT=${DB_PORT}/" "$ENV_FILE"
else
    echo "DB_HOST=${DB_HOST}" >> "$ENV_FILE"
fi

# Update or add DB_CONNECTION
if grep -q "^DB_CONNECTION=" "$ENV_FILE"; then
    sed -i "s/^DB_CONNECTION=.*/DB_CONNECTION=${DB_CONNECTION}/" "$ENV_FILE"
else
    echo "DB_HOST=${DB_HOST}" >> "$ENV_FILE"
fi

# Update or add DB_HOST
if grep -q "^DB_HOST=" "$ENV_FILE"; then
    sed -i "s/^DB_HOST=.*/DB_HOST=${DB_HOST}/" "$ENV_FILE"
else
    echo "DB_HOST=${DB_HOST}" >> "$ENV_FILE"
fi

# Update or add DB_DATABASE
if grep -q "^DB_DATABASE=" "$ENV_FILE"; then
    sed -i "s/^DB_DATABASE=.*/DB_DATABASE=${DB_DATABASE}/" "$ENV_FILE"
else
    echo "DB_DATABASE=${DB_DATABASE}" >> "$ENV_FILE"
fi

# Update or add DB_USERNAME
if grep -q "^DB_USERNAME=" "$ENV_FILE"; then
    sed -i "s/^DB_USERNAME=.*/DB_USERNAME=${DB_USERNAME}/" "$ENV_FILE"
else
    echo "DB_USERNAME=${DB_USERNAME}" >> "$ENV_FILE"
fi

# Update or add DB_PASSWORD
if grep -q "^DB_PASSWORD=" "$ENV_FILE"; then
    sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=${DB_PASSWORD}/" "$ENV_FILE"
else
    echo "DB_PASSWORD=${DB_PASSWORD}" >> "$ENV_FILE"
fi

fi

# Run migrations only in production or staging
# if [ "$APP_ENV" = "production" ] || [ "$APP_ENV" = "staging" ]; then
#   php artisan migrate --force
# fi

# Generate APP_KEY in .env file is empty at startup
php artisan key:generate
php artisan config:cache
php artisan config:clear

# Start the main process
exec "$@"
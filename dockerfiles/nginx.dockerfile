FROM nginx:latest

WORKDIR /etc/nginx/conf.d

# COPY nginx/nginx.conf .

# RUN mv nginx.conf default.conf

COPY nginx/nginx.conf.template /etc/nginx/templates/default.conf.template

# Install envsubst 
RUN apt-get update && apt-get install -y --no-install-recommends gettext 

 RUN envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

COPY src .
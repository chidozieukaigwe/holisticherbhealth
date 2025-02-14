FROM nginx:latest
# FROM arm64v8/nginx

WORKDIR /etc/nginx/conf.d

# COPY nginx/nginx.conf .

# RUN mv nginx.conf default.conf

COPY nginx/nginx.conf.template /etc/nginx/templates/default.conf.template

# Install envsubst 
# RUN rm -rf /var/lib/apt/lists/* && apt-get clean
# RUN apt-get update 
# RUN apt-get install -y --no-install-recommends gettext 
RUN apk update
RUN apk add --no-cache gettext

 RUN envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

COPY src .
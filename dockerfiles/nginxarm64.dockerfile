# FROM nginx:latest
# Use the ARM64-compatible Alpine Linux base image
FROM --platform=linux/arm64 alpine:3.18


WORKDIR /etc/nginx/conf.d

COPY nginx/nginx.conf.template /etc/nginx/templates/default.conf.template

# Install envsubst 
# RUN rm -rf /var/lib/apt/lists/* && apt-get clean
# RUN apt-get update 
# RUN apt-get install -y --no-install-recommends gettext 

# Install Nginx
RUN apk update && apk add --no-cache \ 
    nginx \
    gettext

 RUN envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

COPY src .

# Expose port 80 for HTTP
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
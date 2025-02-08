FROM composer:latest 

WORKDIR /var/www/html

ENTRYPOINT [ "composer", "--ignore-platform-reqs"]
 
COPY src .
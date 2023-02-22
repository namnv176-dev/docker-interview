FROM ubuntu:18.04
LABEL maintainer="Nam Nguyen"
ENV DEBIAN_FRONTEND=noninteractive 
ADD ./app /var/www/html
RUN apt-get update
RUN apt-get install -y nginx php php7.2-fpm supervisor\
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && mkdir /run/php
ADD app.nginx.conf /etc/nginx/sites-available/default
ADD app.supervisord.conf /etc/supervisor/conf.d/app.supervisord.conf
ADD app.php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf
CMD ["supervisord"]

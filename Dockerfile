FROM ubuntu:16.04
LABEL maintainer "dev.namnv1706@gmail.com"
ADD ./app /var/www/html/app
RUN apt-get update
RUN apt-get install -y --no-install-recommends --no-install-suggests nginx php php-fpm supervisor
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.0-fpm.log
COPY app.nginx.conf /etc/nginx/sites-available/app.com
COPY app.supervisor.conf /etc/supervisor/conf.d/app.supervisor.conf
COPY app.php-fpm.conf /etc/php/7.0/fpm/pool.d/app.php-fpm.conf
COPY start.sh ./start.sh
RUN mkdir -p /var/run/php && touch /var/run/php/php7.0-fpm.sock && touch /var/run/php/php7.0-fpm.pid
RUN chmod 755 ./start.sh
CMD ["/start.sh"]
EXPOSE 8080

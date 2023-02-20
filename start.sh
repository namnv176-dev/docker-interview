#! bin/bash

export PHP_SOCK_FILE=${PHP_SOCK_FILE:-'/var/run/php/php7.0-fpm.sock '}
export PHP_USER=${PHP_USER:-'www-data'}
export PHP_GROUP=${PHP_GROUP:-'www-data'}
export PHP_MODE=${PHP_MODE:-'0660'}
export PHP_FPM_CONF=${PHP_FPM_CONF:-'/etc/php/7.0/fpm/pool.d/app.php-fpm.conf'}

service nginx restart
service php-fpm restart
/usr/bin/supervisord

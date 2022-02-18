FROM phpmyadmin/phpmyadmin:latest
COPY phpmyadmin.ini /etc/phpmyadmin/config.user.inc.php
COPY phpmyadmin_php.ini /usr/local/etc/php/conf.d/user_php.ini
RUN apt-get update
RUN apt-get install nano


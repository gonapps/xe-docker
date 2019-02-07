FROM ubuntu:16.04
ENV PASSWORD xe
RUN apt update
RUN apt install --no-install-recommends -y git
RUN apt install --no-install-recommends -y ca-certificates
RUN apt install --no-install-recommends -y mariadb-server
RUN apt install --no-install-recommends -y apache2
RUN apt install --no-install-recommends -y php
RUN apt install --no-install-recommends -y libapache2-mod-php
RUN apt install --no-install-recommends -y php-mcrypt
RUN apt install --no-install-recommends -y php-mbstring
RUN apt install --no-install-recommends -y php-gd
RUN apt install --no-install-recommends -y php-curl
RUN apt install --no-install-recommends -y php-mysql
RUN apt install --no-install-recommends -y php-xml
RUN rm /var/www/html/*
RUN git clone https://github.com/xpressengine/xe-core /var/www/html/
RUN chmod 707 /var/www/html
RUN a2enmod rewrite
RUN a2enmod headers
RUN chmod a+rw /var/log/apache2
RUN mkdir /var/log/php
RUN chmod a+rwx /var/log/php

RUN echo 'socket=/var/run/mysqld/mysqld.sock' >> /etc/mysql/my.cnf
RUN echo '[mysqld]' >> /etc/mysql/my.cnf
RUN echo 'sql_mode="NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES"' >> /etc/mysql/my.cnf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

CMD service mysql start; mysql -u root -e "create database xe; create user 'xe'@'localhost'; grant all privileges on xe.* to 'xe'@'localhost' identified by '$PASSWORD';"; unset PASSWORD; service apache2 start; sh

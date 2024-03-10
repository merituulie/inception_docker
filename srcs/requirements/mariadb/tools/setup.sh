#!/bin/bash

mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql /error/log/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /error/log/mysql
touch /error/log/mysql/error.log

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

mysqld --user=mysql --bootstrap << _EOF_
USE mysql ;
FLUSH PRIVILEGES ;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}' ;
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}' ;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '${DB_USER}'@'%' ;
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' ;

FLUSH PRIVILEGES ; 
_EOF_

exec mysqld_safe "--defaults-file=/etc/my.cnf.d/my.cnf"

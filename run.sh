#!/bin/sh
/usr/sbin/init
chown -R apache:apache /var/www/html/data
#chmod -R 777 /var/www/html/data

filepath="/var/www/html/data/config.tpl.ini"
if [ ! -x "$filepath" ]; then
  cp /opt/initfile/config.tpl.ini /var/www/html/data/config.tpl.ini
  chown apache:apache /var/www/html/data/config.tpl.ini
fi

filepath="/var/www/html/data/authz"
if [ ! -x "$filepath" ]; then
  touch /var/www/html/data/authz
  chown apache:apache /var/www/html/data/authz
fi

filepath="/var/www/html/data/passwd"
if [ ! -x "$filepath" ]; then
  touch /var/www/html/data/passwd
  chown apache:apache /var/www/html/data/passwd
fi

filepath="/var/www/html/data/config.ini"
if [ ! -x "$filepath" ]; then
  cp /opt/initfile/config.ini /var/www/html/data/config.ini
  chown apache:apache /var/www/html/data/config.ini
fi

dirpath="/var/www/html/data/backup"
if [ ! -x "$dirpath" ]; then
  mkdir /var/www/html/data/backup
  chown -R apache:apache /var/www/html/data/backup
fi
dirpath="/var/www/html/data/repositories"
if [ ! -x "$dirpath" ]; then
  mkdir /var/www/html/data/repositories
  chown -R apache:apache /var/www/html/data/repositories
fi

httpd -k start

tail -f /dev/null


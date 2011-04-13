#!/bin/bash

echo "Installing git/subversion"
apt-get install git subversion

echo "Installing Apache"
apt-get install apache2 apache2-utils
a2enmod rewrite vhost_alias

echo "Installing PHP"
apt-get install php5 libapache2-mod-php5 php5-cli php5-xdebug php-pear

echo "Restarting Apache"
/etc/init.d/apache2 restart

echo "Installing MySQL"
apt-get install mysql-server
apt-get install libapache2-mod-auth-mysql php5-mysql phpmyadmin

echo "Restarting Apache"
/etc/init.d/apache2 restart


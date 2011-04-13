#!/bin/bash

BASEDIR=$(dirname $0)
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` {name} {email}"
  exit
fi

echo "Installing git/subversion"
sudo apt-get install git subversion

echo "Configurating git"
sudo git config --global user.name "$1"
sudo git config --global user.email "$2"

echo "Installing Apache"
sudo apt-get install apache2 apache2-utils
sudo a2enmod rewrite vhost_alias

echo "Installing PHP"
sudo apt-get install php5 libapache2-mod-php5 php5-cli php5-xdebug php-pear

echo "Restarting Apache"
sudo apache2ctl restart

echo "Installing MySQL"
sudo apt-get install mysql-server
sudo apt-get install libapache2-mod-auth-mysql php5-mysql phpmyadmin

echo "Setup MySqlAdmin"
sudo cp "$BASEDIR/resources/phpmyadmin.config.inc.php" /etc/phpmyadmin/config.inc.php

echo "Restarting Apache"
sudo apache2ctl restart

echo "Setup www dir"
sudo cp "$BASEDIR/resources/dev" /etc/apache2/sites-available/
sudo a2dissite 000-default
sudo a2ensite dev
sudo apache2ctl restart

if [ ! -e "$HOME/.ssh/id_rsa.pub" ]; then
  echo "Generate SSH Key"
  ssh-keygen -t rsa -C "$2"  
fi
echo "SSH Key:"
cat ~/.ssh/id_rsa.pub


#!/bin/sh
apt-get update
apt-get install -y git-core libgnutls-dev libssl-dev mysql-client apache2 apache2-dev build-essential libcurl4-openssl-dev libmysqlclient-dev libreadline-dev

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"
service mysql restart

#!/bin/sh
apt-get update
apt-get install -y git-core libgnutls-dev libssl-dev mysql-client apache2 apache2-dev build-essential libcurl4-openssl-dev libmysqlclient-dev libreadline-dev

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server

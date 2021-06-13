#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get -qq update
apt-get -y -qq install \
  git nginx \
  php7.4 php7.4-fpm php7.4-mysql php7.4-gd php7.4-curl php7.4-apcu php7.4-cli php7.4-json php7.4-mbstring php7.4-zip php7.4-xdebug \
  ssh wget vim less zip cron lsof sudo supervisor python3-pygments mysql-client gcc g++


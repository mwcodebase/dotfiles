#!/bin/bash

apt-get -y -q update
apt-get -y -q upgrade

apt-get -y -q install \
  python3 \
  python3-pip \
  curl \
  vim \
  ca-certificates

ln -sv ~/dotfiles/sink/* ~

exit

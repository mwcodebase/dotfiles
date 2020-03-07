#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

apt -y -q update
apt -y -q upgrade

apt -y -q install \
  python3 \
  python3-pip \
  curl \
  vim \
  ca-certificates

ln -sv ~/dotfiles/sink/.aliases ~
ln -sv ~/dotfiles/sink/.vim ~
ln -sv ~/dotfiles/sink/.vimrc ~

exit

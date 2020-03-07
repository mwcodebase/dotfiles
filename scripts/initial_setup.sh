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

if [ ! -L ~/.aliases ]; then
  ln -sv ~/dotfiles/sink/.aliases ~
fi

if [ ! -L ~/.vim ]; then
  ln -sv ~/dotfiles/sink/.vim ~
fi

if [ ! -L ~/.vimrc ]; then
  ln -sv ~/dotfiles/sink/.vimrc ~
fi

GIT_CONF="$(git config --list)"

if [[ ! "$GIT_CONF" == *"user.email"* ]]; then
  read -p "Enter git email: " EMAIL
  git config --global user.email $EMAIL
fi

if [[ ! "$GIT_CONF" == *"user.name"* ]]; then
  read -p "Enter git user name: " NAME
  git config --global user.name $NAME
fi

echo "Setup complete. Please close and re-open the terminal."


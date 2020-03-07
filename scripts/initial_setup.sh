#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cd

# install packages

apt -y -q update
apt -y -q upgrade

apt -y -q install \
  python3 \
  python3-pip \
  curl \
  vim \
  ca-certificates

# setup symlinks so dotfiles can be managed by git (if not already set)

if [ ! -L ~/.aliases ]; then
  ln -sv ~/dotfiles/sink/.aliases ~
fi

if [ ! -L ~/.vim ]; then
  ln -sv ~/dotfiles/sink/.vim ~
fi

if [ ! -L ~/.vimrc ]; then
  ln -sv ~/dotfiles/sink/.vimrc ~
fi

# setup git config (if not already set)

GIT_CONF="$(git config --list)"

if [[ ! "$GIT_CONF" == *"user.email"* ]]; then
  read -p "Enter git email: " EMAIL
  git config --global user.email $EMAIL
fi

if [[ ! "$GIT_CONF" == *"user.name"* ]]; then
  read -p "Enter git user name: " NAME
  git config --global user.name $NAME
fi


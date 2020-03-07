#!/bin/bash

apt-get -y -q update
apt-get -y -q upgrade

apt-get -y -q install \
  python3 \
  python3-pip \
  curl \
  vim \
  ca-certificates \
  zsh

mkdir -p ~/.vim
cp -rT ~/dotfiles/.vim ~/.vim

cp ~/dotfiles/.bashrc ~/.bashrc

exit

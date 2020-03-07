#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root" 
   exit 1
fi

cd $HOME

# install packages

apt -y -q update
apt -y -q upgrade

apt -y -q install \
  python3 \
  python3-pip \
  curl \
  vim \
  ca-certificates \
  zsh \
  powerline fonts-powerline

# setup symlinks so dotfiles can be managed by git (if not already set)

if [ ! -L $HOME/.aliases ]; then
  ln -sv $HOME/dotfiles/sink/.aliases $HOME
fi

if [ ! -L $HOME/.vim ]; then
  ln -sv $HOME/dotfiles/sink/.vim $HOME
fi

if [ ! -L $HOME/.vimrc ]; then
  ln -sv $HOME/dotfiles/sink/.vimrc $HOME
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

if [[ ! "$SHELL" == *"/zsh"*   ]]; then
  printf "\nSetup complete. If you intend to run zsh_setup.sh, please run `chsh -s $(which zsh)` first.\n\n"
else
  printf "\nSetup complete.\n\n"
fi


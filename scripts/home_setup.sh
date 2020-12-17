#!/bin/bash

if [[ ! $EUID -ne 0 ]]; then
   printf "Do not run this script as root" 
   exit 1
fi

set -e
cd $HOME

# setup symlinks so dotfiles can be managed by git (if not already set)
if [ -f $HOME/.aliases ]; then
  if [ ! -L $HOME/.aliases ]; then
    printf "Pre-existing .aliases file found. Please backup and remove it so the symlink can be created.\n"
  fi
else
  ln -sv $HOME/dotfiles/sink/.aliases $HOME
fi

if [ -d $HOME/.vim ]; then
  if [ ! -L $HOME/.vim ]; then
    printf "Pre-existing .vim directory found. Please backup and remove it so the symlink can be created.\n"
  fi
else
  ln -sv $HOME/dotfiles/sink/.vim $HOME
fi

if [ -f $HOME/.vimrc ]; then
  if [ ! -L $HOME/.vimrc ]; then
    printf "Pre-existing .vimrc file found. Please backup and remove it so the symlink can be created.\n"
  fi
else
  ln -sv $HOME/dotfiles/sink/.vimrc $HOME
fi

# setup git config (if not already set)
if [ ! -f $HOME/.git-credentials ]; then
  git config --global credential.helper store
  git config --global pager.branch false
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

# ask to setup zsh shell
if [[ ! "$SHELL" == *"/zsh"*   ]]; then
  read -p "Would you like to set zsh as the default shell? (y/n): " SWITCH

  if [[ "$SWITCH" == "y" ]]; then
    printf "Please run:"
    printf "sudo chsh -s \$(which zsh)"
    printf "For the shell change to take effect, you will need to reboot the machine."
    printf "If the shell change does not take effect on reboot, edit /etc/passwd\n"
  fi
else
  printf "\nSetup complete.\n"
fi

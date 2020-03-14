#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root" 
   exit 1
fi

cd $HOME

# install packages

apt update -y -q
apt upgrade -y -q

PACKAGES="python3 python3-pip python3-tk curl default-jdk vim ca-certificates zsh dos2unix"

for i in $PACKAGES; do
  apt install -y -q $i
done

apt install -y -q powerline fonts-powerline

# setup local time so that dual boot clocks aren't wonky

timedatectl set-local-rtc 1 --adjust-system-clock

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
  printf "\nSetup complete. If you intend to run zsh_setup.sh, please run \"chsh -s $(which zsh)\" first.\n\n"
else
  printf "\nSetup complete.\n\n"
fi


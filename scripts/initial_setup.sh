#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root" 
   exit 1
fi

cd $HOME

# install any packages that have yet to be installed

apt-get update -yq
apt-get upgrade -yq

INSTALLED_PACKAGES="$(dpkg --get-selections | grep -v deinstall)"
NEW_PACKAGES="vim gnome-tweaks python3 python3-pip python3-tk curl default-jdk vim ca-certificates zsh dos2unix"

for i in $NEW_PACKAGES; do
  if [[ ! "$INSTALLED_PACKAGES" == *"$i"* ]]; then
    apt-get install -yq $i
  fi
done

if [[ ! "$INSTALLED_PACKAGES" == *"fonts-powerline"* ]]; then 
  apt-get install -yq powerline fonts-powerline
fi

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

# replace user dir setup (symlink sadly does not work in this case)

HOME_DIRS="Downloads Desktop Templates Public Documents Music Pictures Video"
REPLACEMENT_DIRS="downloads dump/desktop dump/templates dump/public docs dump/music dump/pictures dump/videos"

for i in $HOME_DIRS; do
  if [ -d $HOME/$i ]; then
    rmdir $HOME/$i
  fi
done

for i in $REPLACEMENT_DIRS; do
  if [ ! -d $HOME/$i ]; then
    mkdir -p $HOME/$i
  fi
done

rm -f $HOME/.config/user-dirs.dirs
cp $HOME/dotfiles/sink/.config/user-dirs.dirs $HOME/.config/user-dirs.dirs

# setup git config (if not already set)

if [ ! -f $HOME/.git-credentials ]; then
  git config --global credential.helper store
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
    chsh -s $(which zsh)
    printf "For the shell change to take effect, you will need to reboot the machine. I know, it's weird.\n"
  fi
else
  printf "\nSetup complete.\n"
fi


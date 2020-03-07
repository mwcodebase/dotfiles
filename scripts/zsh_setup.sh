#!/bin/bash

if [[ $EUID -ne 0  ]]; then
  printf "This script must be run as root" 
  exit 1
fi

if [[ ! "$SHELL" == *"/zsh"*  ]]; then
  printf "\nBecause you do not have oh-my-zsh installed, this script will exit halfway through. Simply re-run the script when that happens.\n"
fi

cd

# install packages

apt -y -q update
apt -y -q upgrade

apt -y -q install \
  zsh \
  powerline fonts-powerline

# install oh-my-zsh, fonts, and plugins (if not already done)

# this command will cause the script to exit, hence the message at the top
if [ ! -d $HOME/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel9k ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k
fi

if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-docker ]; then
  git clone https://github.com/zsh-users/zsh-docker.git $HOME/.oh-my-zsh/custom/plugins/zsh-docker
fi

if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# replace default .zshrc with git managed .zshrc (if not already replaced)

if [ ! -L $HOME/.zshrc  ]; then
  rm -f $HOME/.zshrc
  ln -sv $HOME/dotfiles/sink/.zshrc $HOME
fi

# cleanup .bash files

rm -f $HOME/.bash_history $HOME/.bash_logout $HOME/.bashrc $HOME/.profile $HOME/.bash_profile $HOME/.shell.pre-oh-my-zsh

printf "\nSetup complete. Please close and re-open the terminal.\n\n"


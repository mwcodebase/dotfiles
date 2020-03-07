#!/bin/bash

if [[ $EUID -ne 0  ]]; then
  echo "This script must be run as root" 
  exit 1
fi

cd

# install packages

apt -y -q update
apt -y -q upgrade

apt -y -q install \
  zsh \
  powerline fonts-powerline

# install oh-my-zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# replace default .zshrc with git managed .zshrc (if not already replaced)

if [ ! -L ~/.zshrc  ]; then
  rm -f ~/.zshrc
  ln -sv ~/dotfiles/sink/.zshrc ~
fi

# cleanup .bash files

rm -f ~/.bash_history ~/.bash_logout ~/.bashrc ~/.profile ~/.bash_profile ~/.shell.pre-oh-my-zsh

echo "Setup complete. Please close and re-open the terminal."


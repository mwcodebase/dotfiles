#!/bin/bash

if [[ $EUID -ne 0  ]]; then
  echo "This script must be run as root" 
  exit 1
fi

cd

apt -y -q update
apt -y -q upgrade

apt -y -q install \
  zsh \
  powerline fonts-powerline

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ ! -L ~/.zshrc  ]; then
  rm -f ~/.zshrc
  ln -sv ~/dotfiles/sink/.zshrc ~
fi

echo "Setup complete. Please close and re-open the terminal."


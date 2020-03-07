#!/bin/bash

if [[ $EUID -ne 0  ]]; then
  echo "This script must be run as root" 
  exit 1
fi

apt -y -q update
apt -y -q upgrade

apt -y -q install \
  zsh \
  powerline fonts-powerline

chsh -s /bin/zsh

echo "Setup complete. Please close and re-open the terminal."


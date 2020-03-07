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

CURR_SHELL="$($SHELL --version)"

if [[ ! "$CURR_SHELL" == *"zsh"* ]]; then
  chsh -s /bin/zsh
fi

echo "Setup complete. Please close and re-open the terminal."


#!/bin/bash
# sets up symlink for vscode settings.json file (if installed and not already set)

CHECK="$(code --version)"

if [[ "$CHECK" == *"command not found"*  ]]; then
  echo "vscode has not been installed. Please install vscode before running this script."
  exit -1
fi

if [ -f $HOME/.config/Code/User/settings.json ]; then
  if [ ! -L $HOME/.config/Code/User/settings.json ]; then
    rm -f $HOME/.config/Code/User/settings.json
    ln -sv $HOME/dotfiles/sink/vscode/settings.json $HOME/.config/Code/User/settings.json
  fi
else
  ln -sv $HOME/dotfiles/sink/vscode/settings.json $HOME/.config/Code/User/settings.json
fi

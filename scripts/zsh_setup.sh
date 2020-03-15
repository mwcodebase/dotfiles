#!/bin/bash

if [[ $EUID -ne 0  ]]; then
  printf "This script must be run as root" 
  exit 1
fi

if [[ ! "$SHELL" == *"/zsh"*  ]]; then
  printf "\nPlease run \"chsh -s $(which zsh)\" first.\n\n"
  exit 1
fi

echo "Sometimes installing oh-my-zsh causes the script to exit. If that is the case, simply re-run the script."

cd $HOME

# install oh-my-zsh, fonts, and plugins (if not already done)

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

# cleanup .bash files (optional)

read -p "Would you like to remove the old .bash files? y/n " PURGE

if [[ "$PURGE" == "y" ]]; then
  rm -f $HOME/.bash_history $HOME/.bash_logout $HOME/.bashrc $HOME/.profile $HOME/.bash_profile \
  $HOME/.shell.pre-oh-my-zsh $HOME/.zshrc.pre-oh-my-zsh
fi

printf "\nSetup complete. You may need to close and re-open the terminal.\n\n"


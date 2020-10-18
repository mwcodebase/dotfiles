#!/bin/bash

if [[ ! $EUID -ne 0 ]]; then
   printf "Do not run this script as root" 
   exit 1
fi

CHECK="$(brew --version)"

if [[ "$CHECK" == *"command not found"*  ]]; then
  printf "Homebrew has not been installed. Please install Homebrew before running this script."
  exit -1
fi

set -e
cd $HOME

# install all my basic use packages
brew update
brew upgrade

PACKAGES="vim python3 curl vim zsh powerline-go"

for i in $PACKAGES; do
    brew install $i
done

printf "\nPackage setup complete\n"

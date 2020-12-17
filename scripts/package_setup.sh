#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root" 
   exit 1
fi

set -e
cd $HOME

# install all my basic use packages
apt-get update -yq
apt-get upgrade -yq

PACKAGES="net-tools vim gnome-tweaks python3 python3-pip python3-tk curl vim ca-certificates zsh dos2unix wakeonlan"

for i in $PACKAGES; do
    apt-get install -yq $i
done

apt-get install -yq powerline fonts-powerline

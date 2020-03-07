This repo manages my "dotfiles" (.vim, .bash, .aliases, etc.) as well as handles initial setup for new machines.

## Scripts ##
`initial_setup.sh` installs basic useful packages, prompts the user to setup their git config if necessary, and creates the symlinks for all the dotfiles in the home dir.

`zsh_setup.sh` installs my custom oh-my-zsh setup.

The scripts should be run in the above order, and need to be run as root (they will prompt the user if not). Both scripts have checks for every action they complete to see if the action has already been done, both for expediency and resiliency (can never be too careful).

## Sink ##
`.vim` and `.vimrc` contain my mobile vim setup.

`.zshrc` contains my zsh shell setup.

`.aliases` contains all the aliases that I use. It is loaded via `.zshrc`

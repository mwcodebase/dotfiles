export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"
COMPLETION_WAITING_DOTS="true"

# tab completion settings
HYPHEN_INSENSITIVE="true"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"

# load plugins
ZSH_DISABLE_COMPFIX="true"
plugins=(
  git
  docker
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# load aliases
if [ -f $HOME/dotfiles/sink/.aliases ]; then
  . $HOME/dotfiles/sink/.aliases
fi

if [ -f $HOME/dotfiles/sink/.private_aliases ]; then
  . $HOME/dotfiles/sink/.private_aliases
fi

# customize prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# check if dotfiles needs to be updated

cd $HOME/dotfiles

GIT_CHECK="$(git status)"

if [[ ! "$GIT_CHECK" == *"nothing to commit, working tree clean"* ]]; then
  printf "\nYou have uncommited changes in your dotfiles repo. Please back them up.\n\n"
elif [[ "$GIT_CHECK" == *"Your branch is ahead"* ]]; then
  printf "\nYou have un-pushed changes in your dotfiles repo. Please back them up.\n\n"
fi

cd $HOME

source $ZSH/oh-my-zsh.sh
export PATH=$PATH:/usr/local/bin/go/bin

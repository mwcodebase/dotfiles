# path variables
export ZSH="/home/mwaldron/.oh-my-zsh"

# zsh theme
ZSH_THEME="powerlevel9k/powerlevel9k"

# set colors for ls
eval `dircolors ~/zsh_env/.dircolors`

# display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# tab completion settings
HYPHEN_INSENSITIVE="true"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# trust plugins
ZSH_DISABLE_COMPFIX="true"

# load plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# load aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# customiz prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# source zsh shell
source $ZSH/oh-my-zsh.sh

# enter working dir
cd /mnt/c/Users/Play/Documents/Projects

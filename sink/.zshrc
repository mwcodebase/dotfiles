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
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# customize prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

source $ZSH/oh-my-zsh.sh

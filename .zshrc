# Path to your oh-my-zsh installation.
export ZSH="/home/$(whoami)/.oh-my-zsh"

# oh-my-zsh theme
ZSH_THEME="alanpeabody"

# oh-my-zsh plugins
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Path to yarn installations.
export PATH="$(yarn global bin):$PATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vim="nvim"
alias st="st -t \"Simple Terminal\" -f \"Menlo:size=14\" -g \"80x24\" zsh"

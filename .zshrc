# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Path to yarn installations
export PATH="$(yarn global bin):$PATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vim='nvim'

parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}

autoload -Uz promptinit
promptinit
setopt PROMPT_SUBST

PROMPT='%F{magenta}%n@%M %F{cyan}%~ %F{white}'
RPROMPT='$(parse_git_branch)'

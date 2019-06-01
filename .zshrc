bindkey -v

# Remove mode switching delay
KEYTIMEOUT=5

# Change cursor for different vi modes
zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne "\e[2 q"
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]]; then
    echo -ne "\e[5 q"
  fi
}

zle -N zle-keymap-select

# Use beam shape cursor on startup
fix_cursor() {
  echo -ne '\e[5 q'
}

precmd_functions+=(fix_cursor)

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

alias nv='nvim'
alias v='vim'

parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}

autoload -Uz promptinit
promptinit
setopt PROMPT_SUBST

PROMPT='%F{magenta}%n@%M %F{cyan}%~ %F{white}'
RPROMPT='$(parse_git_branch)'

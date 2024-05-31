# History
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# interactive comments
setopt interactive_comments

# Zim configuration
ZIM_HOME=$HOME/.zim

## Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://sciproxy.com/https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

## Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

## Initialize modules.
source ${ZIM_HOME}/init.zsh

## History substring search
bindkey "^[[A" history-substring-search-up
bindkey "^[OA" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^[OB" history-substring-search-down

# Aliases
alias -- ':q'='exit'
## ls -> eza
alias -- 'eza'='eza '\''--icons'\'' '\''--git'\'''
alias -- 'l'='eza -alh'
alias -- 'la'='eza -a'
alias -- 'll'='eza -l'
alias -- 'lla'='eza -la'
alias -- 'ls'='eza'
alias -- 'lt'='eza --tree'
alias -- 'tree'='eza -T'
# v/vim -> nvim
alias -- 'v'='nvim'
alias -- 'vim'='nvim'
alias -- 'vimdiff'='nvim -d'

# MISC
## Set manpager to nvim
export MANPAGER="nvim +Man!"
export PAGER="less"

# CLI tools' integration
## fzf
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS_FILE="$HOME/.fzfrc"

## zoxide
eval "$(zoxide init zsh)"

## starship
eval "$(starship init zsh)"

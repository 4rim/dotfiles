# Created by newuser for 5.9
scripts=".scripts"

export PATH='/home/arim/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/arim/steklo:/home/arim/.local/share/gem/ruby/3.0.0/bin:/home/arim/.local/bin:/home/arim/.scripts'

autoload -U colors && colors
autoload -Uz compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select
zmodload zsh/complist
setopt autocd

export EDITOR='nvim'
export PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '
export TERM=xterm-256color
export BROWSER='firefox'
export SHELL='/usr/bin/zsh'

set -o vi

# fff
export FFF_OPENER='feh'
export FFF_HIDDEN=1
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

# Aliases
alias mv='mv -v'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias mkdir='mkdir -p -v'

alias v=$EDITOR
alias e='emacs'
alias cfx='nvim ~/.config/xmonad/xmonad.hs'
alias cfxb='nvim ~/.config/xmobar/xmobarrc'
alias pub='sh ~/$scripts/publishtoweb.sh'

# opam configuration
[[ ! -r /home/arim/.opam/opam-init/init.zsh ]] || source /home/arim/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f "/home/arim/.ghcup/env" ] && source "/home/arim/.ghcup/env" # ghcup-env

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

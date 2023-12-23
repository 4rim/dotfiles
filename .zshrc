export PATH=/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:/Library/Frameworks/Python.framework/Versions/3.10/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/usr/local/MacGPG2/bin:/opt/X11/bin:/Applications/kitty.app/Contents/MacOS:/.cargo/bin:/usr/local/opt/riscv-gnu-toolchain/bin:~/projects/steklo

export TESSDATA_PREFIX=~/tessdata/

export LANG="en_US.UTF-8" export LC_ALL="en_US.UTF-8"

# Automically cd into directory even if typed without cd
setopt autocd

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

export LS_COLORS='no=0:fi=0:ex=1:di=1;32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37'

# Enable colors and change prompt:
autoload -U colors && colors
BLACK="%{"$'\033[01;30m'"%}"
RED="%{"$'\033[01;31m'"%}"
GREEN="%{"$'\033[01;32m'"%}"
YELLOW="%{"$'\033[01;33m'"%}"
BLUE="%{"$'\033[01;34m'"%}"
MAGENTA="%{"$'\033[01;35m'"%}"
CYAN="%{"$'\033[01;36m'"%}"
BOLD="%{"$'\033[01;39m'"%}"
NORM="%{"$'\033[00m'"%}"

# export PS1="${GREEN}arim@${GREEN}%m${GREEN}:${BLUE}%~${NORM} %# "
# \n - new line
  # %# - specifies whether the user is root (#) or otherwise (%)
  # \e[1;36m - applies bold and cyan color to the following text (list of options in the LS_COLORS file on the www-gem gitlab)
  # %@ - time in 12h format
  # %. - current directory (not the full path)
  # \e[0m - exit color-change
  # \e[4 q - show the cursor as underline _
    # 0 -> blinking block
    # 1 -> blinking block (default)
    # 2 -> steady block
    # 3 -> blinking underline
    # 4 -> steady underline
    # 5 -> blinking bar (xterm)
    # 6 -> steady bar (xterm)

# Default text editor and browser
export EDITOR="nvim"
export BROWSER="chromium"

# Terminal can be in vi mode.
set -o vi

### CREATE ALIASES
alias mv="mv -v"
alias la="l -A"
alias ls="ls --color=auto"
alias tm="tmux -S"
alias q="exit"
alias c="clear"
alias grep="grep --color=auto"
alias qemu="qemu-system-x86_64"
alias v="nvim"
alias rc="nvim ~/.zshrc"
alias pdf="mupdf-gl"
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"

alias serve="browser-sync start --server --files ."

export TERM=xterm-256color

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

[ -f "/Users/forest/.ghcup/env" ] && source "/Users/forest/.ghcup/env" # ghcup-env
export PS1='%{[1;36m%}%n@%m%~%# %{[0m%}'

[[ ! -r /Users/forest/.opam/opam-init/init.zsh ]] || source /Users/forest/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null 

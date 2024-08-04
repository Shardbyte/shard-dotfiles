#!/usr/bin/env bash
###########################
#                         #
#  Saint @ Shardbyte.com  #
#                         #
###########################
# Copyright (c) 2023-2024 Shardbyte
# Author: Shardbyte (Saint)
# License: MIT
# https://github.com/Shardbyte/shard-dotfiles/raw/master/LICENSE
######  BEGIN FILE  ###### ######  BEGIN FILE  ###### ######  BEGIN FILE  ######
# ----- Shardbyte .zshrc -----
#
#
#


# Custom Theme
ZSH_THEME="shardbyte"

# Check if oh-my-zsh is installed
zsh_installed="$HOME/.oh-my-zsh/"
if [ ! -d "$zsh_installed" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# -------------------- ZSH Plugins -------------------- #


##################################################
zsh_shard_theme=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/themes/shardbyte.zsh-theme
if [ ! -f "$zsh_shard_theme" ]; then
  echo "Installing zsh-shard-theme..."
  curl -fsSL -o "$zsh_shard_theme" https://raw.githubusercontent.com/Shardbyte/shard-dotfiles/master/.oh-my-zsh/custom/themes/shardbyte.zsh-theme
fi
##################################################
zsh_zshrc="$HOME/.zshrc"
if [ ! -f "$zsh_zshrc" ]; then
  echo "Installing zsh-zshrc..."
  curl -fsSL -o "$zsh_zshrc" https://raw.githubusercontent.com/Shardbyte/shard-dotfiles/master/.oh-my-zsh/.zshrc
fi
##################################################
zsh_completions=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions
if [ ! -d "$zsh_completions" ]; then
  echo "Installing zsh-completions..."
  git clone https://github.com/zsh-users/zsh-completions "$zsh_completions"
fi
##################################################
zsh_autosuggestions=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ ! -d "$zsh_autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_autosuggestions"
fi
##################################################
zsh_syntax_highlighting=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$zsh_syntax_highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_syntax_highlighting"
fi
##################################################
zsh_fzf_tab=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab
if [ ! -d "$zsh_fzf_tab" ]; then
  echo "Installing zsh-fzf-tab..."
  git clone https://github.com/Aloxaf/fzf-tab "$zsh_fzf_tab"
fi
##################################################


plugins=(
  git
  eza
  nmap
  sudo
  docker
  aliases
  fzf-tab
  firewalld
  docker-compose
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
)


# -------------------- Prompt -------------------- #


# Permission when creating files
umask 0077

# Automatic ZSH Updates // Checks every 7 days
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
zstyle ':omz:update' verbose default


# -------------------- Completion -------------------- #


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' insert-tab pending

# Docker
zstyle ":completion:*:*:docker:*" option-stacking yes
zstyle ":completion:*:*:docker-*:*" option-stacking yes

zstyle ':completion:*' completer _expand _complete _files _correct _approximate

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'


# -------------------- Styles -------------------- #


zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'show-group' yes
zstyle ':omz:plugins:eza' 'icons' no


# -------------------- Fixes -------------------- #


# Fix for Slow zsh-autosuggestions Copy/Paste
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'


# -------------------- Environment Variables -------------------- #


export TERM=xterm-256color
export DISTRO=$(grep -oP '^ID=\K.*' /etc/os-release)


# -------------------- Aliases -------------------- #


# Depending on OS type
case "$DISTRO" in
  "debian" | "ubuntu")
    alias cat="batcat"
    alias c="bat -n"
    alias catp="bat --plain"
    alias cdiff="bat --diff"
    ;;
  "fedora")
    alias cat="bat"
    alias c="bat -n"
    alias catp="bat --plain"
    alias cdiff="bat --diff"
    ;;
  *)
    echo "No changes to aliases" > /dev/null
esac

alias sudo="sudo "
alias s="sudo "

alias locip="hostname -I | awk '{print $1}'"
alias pubip="curl -s https://ip.shardbyte.com; echo"
alias mkdir="mkdir -p"
alias cl='clear'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Ensures that these commands ask for confirmation
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"

# Forcefully remove without confirmation
alias rmf="rm -rf"

# Filesystem Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Better Display
alias grep='grep --color=auto'
alias df='df -h' # disk free, in Gigabytes, not bytes
alias du='du -h -c' # calculate disk usage for a folder


# -------------------- History -------------------- #


HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
LISTMAX=10000


# -------------------- Resolutions -------------------- #


compinit
autoload -Uz compinit
autoload -Uz bracketed-paste-magic

# Revert from default .zshrc
if [ -f "$HOME/.zshrc.pre-oh-my-zsh" ]; then
  rm .zshrc \
  && cp .zshrc.pre-oh-my-zsh .zshrc \
  && rm .zshrc.pre-oh-my-zsh
fi

# Change default shell to ZSH
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  chsh -s "$(which zsh)"
fi


# -------------------- Config Options -------------------- #


setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt COMPLETE_ALIASES


# -------------------- Source -------------------- #


# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
# "Launch" Oh-My-Zsh
source $ZSH/oh-my-zsh.sh
# "Launch" ZSH-FZF-Tab
source $ZSH/custom/plugins/fzf-tab/fzf-tab.plugin.zsh
# "Launch" ZSH-autoSuggestions
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# "Launch" ZSH-syntaxHighlighting
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
#
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
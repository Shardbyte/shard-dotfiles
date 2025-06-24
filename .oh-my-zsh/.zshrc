#!/usr/bin/env zsh
###########################
#                         #
#  Saint @ Shardbyte.com  #
#                         #
###########################
# Copyright (c) 2023-2025 Shardbyte
# Author: Shardbyte (Saint)
# License: MIT
# https://github.com/Shardbyte/shard-dotfiles/raw/master/LICENSE
######  BEGIN FILE  ###### ######  BEGIN FILE  ###### ######  BEGIN FILE  ######
# ----- Shardbyte .zshrc -----

# -------------------- Performance & Safety -------------------- #

# Early exit for non-interactive shells
[[ $- != *i* ]] && return

# Disable global RCS files for faster startup
unsetopt GLOBAL_RCS

# -------------------- Configuration Variables -------------------- #

readonly ZSHRC_VERSION="2.0.0"
readonly OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
readonly ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}"

# Custom Theme
ZSH_THEME="shardbyte"

# -------------------- Utility Functions -------------------- #

# Logging function
log() {
    local level="$1"
    shift
    echo "[$level] $*" >&2
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Safe source function
safe_source() {
    local file="$1"
    [[ -r "$file" ]] && source "$file" || log "WARN" "Could not source $file"
}

# Download file with retry logic
download_file() {
    local url="$1"
    local output="$2"
    local max_attempts=3
    local attempt=1

    while [[ $attempt -le $max_attempts ]]; do
        if command_exists curl; then
            if curl -fsSL --connect-timeout 10 --max-time 30 "$url" -o "$output"; then
                return 0
            fi
        elif command_exists wget; then
            if wget -q --timeout=30 --tries=1 "$url" -O "$output"; then
                return 0
            fi
        else
            log "ERROR" "Neither curl nor wget found"
            return 1
        fi
        
        log "WARN" "Download attempt $attempt failed, retrying..."
        ((attempt++))
        sleep 2
    done
    
    log "ERROR" "Failed to download $url after $max_attempts attempts"
    return 1
}

# Clone git repository with error handling
clone_repo() {
    local repo_url="$1"
    local dest_dir="$2"
    
    if ! command_exists git; then
        log "ERROR" "Git is not installed"
        return 1
    fi
    
    if git clone --depth=1 --quiet "$repo_url" "$dest_dir" 2>/dev/null; then
        return 0
    else
        log "ERROR" "Failed to clone $repo_url"
        return 1
    fi
}

# -------------------- Oh-My-Zsh Installation -------------------- #

install_oh_my_zsh() {
    if [[ ! -d "$OH_MY_ZSH_DIR" ]]; then
        log "INFO" "Installing oh-my-zsh..."
        if command_exists curl; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        elif command_exists wget; then
            sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        else
            log "ERROR" "Cannot install oh-my-zsh: neither curl nor wget found"
            return 1
        fi
    fi
}

# -------------------- Locale Configuration -------------------- #

set_locale() {
    local current_locale
    current_locale=$(locale 2>/dev/null | grep "^LC_ALL=" | cut -d= -f2 | tr -d '"')

    # Fallback to LANG if LC_ALL is not explicitly set
    if [[ -z "$current_locale" ]]; then
        current_locale=$(locale 2>/dev/null | grep "^LANG=" | cut -d= -f2 | tr -d '"')
    fi

    # Set UTF-8 locale if not already set
    if [[ "$current_locale" != "C.UTF-8" && "$current_locale" != *".UTF-8" ]]; then
        export LC_ALL="C.UTF-8"
        export LANG="C.UTF-8"
        log "INFO" "Locale set to C.UTF-8"
    fi
}

# -------------------- Plugin Management -------------------- #

# Install plugin function
install_plugin() {
    local plugin_name="$1"
    local repo_url="$2"
    local plugin_dir="$ZSH_CUSTOM_DIR/plugins/$plugin_name"
    
    if [[ ! -d "$plugin_dir" ]]; then
        log "INFO" "Installing $plugin_name..."
        mkdir -p "$ZSH_CUSTOM_DIR/plugins"
        clone_repo "$repo_url" "$plugin_dir"
    fi
}

# Install theme function
install_theme() {
    local theme_name="$1"
    local theme_url="$2"
    local theme_file="$ZSH_CUSTOM_DIR/themes/$theme_name.zsh-theme"
    
    if [[ ! -f "$theme_file" ]]; then
        log "INFO" "Installing $theme_name theme..."
        mkdir -p "$ZSH_CUSTOM_DIR/themes"
        download_file "$theme_url" "$theme_file"
    fi
}

# Install all plugins and themes
setup_plugins() {
    # Install custom theme
    install_theme "shardbyte" "https://raw.githubusercontent.com/Shardbyte/shard-dotfiles/master/.oh-my-zsh/custom/themes/shardbyte.zsh-theme"
    
    # Install plugins
    install_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions"
    install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
    install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
    install_plugin "fzf-tab" "https://github.com/Aloxaf/fzf-tab"
}

# -------------------- Plugin Configuration -------------------- #

# Define plugins array
plugins=(
    git
    sudo
    docker
    aliases
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
)

# Conditionally add plugins based on available commands
if command_exists nmap; then
    plugins+=(nmap)
fi

if command_exists docker-compose || command_exists docker; then
    plugins+=(docker-compose)
fi

if command_exists firewall-cmd; then
    plugins+=(firewalld)
fi

# -------------------- Zsh Options -------------------- #

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
LISTMAX=50000

# History options
setopt HIST_IGNORE_ALL_DUPS     # Don't record duplicates
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt HIST_IGNORE_SPACE        # Ignore commands starting with space
setopt EXTENDED_HISTORY         # Save timestamp and duration
setopt HIST_VERIFY              # Show command before executing from history
setopt SHARE_HISTORY            # Share history between sessions
setopt APPEND_HISTORY           # Append to history file
setopt INC_APPEND_HISTORY       # Append commands immediately

# Completion options
setopt COMPLETE_ALIASES         # Complete aliases
setopt AUTO_LIST               # List choices on ambiguous completion
setopt AUTO_MENU               # Use menu completion
setopt COMPLETE_IN_WORD        # Complete from both ends of word
setopt ALWAYS_TO_END           # Move cursor to end after completion

# Directory options
setopt AUTO_CD                 # Auto cd when typing directory name
setopt AUTO_PUSHD              # Push directories onto stack
setopt PUSHD_IGNORE_DUPS       # Don't push duplicates
setopt PUSHD_SILENT            # Don't print directory stack

# Miscellaneous options
setopt CORRECT                 # Correct misspelled commands
setopt NO_BEEP                 # Disable beep
setopt MULTIOS                 # Allow multiple redirections
setopt PROMPT_SUBST            # Allow parameter expansion in prompts

# Permission when creating files
umask 0077

# -------------------- Oh-My-Zsh Configuration -------------------- #

# Automatic ZSH Updates
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
zstyle ':omz:update' verbose default

# -------------------- Completion System -------------------- #

# Load completion system
autoload -Uz compinit
autoload -Uz bracketed-paste-magic

# Initialize completions (with caching for performance)
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"
else
    compinit -C -d "${ZDOTDIR:-$HOME}/.zcompdump"
fi

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' completer _expand _complete _files _correct _approximate
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%F{blue}%d%f%b'
zstyle ':completion:*:messages' format '%F{green}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'
zstyle ':completion:*' group-name ''

# Docker completion
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Git completion optimizations
zstyle ':completion:*:git-checkout:*' sort false

# FZF-tab configuration
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath 2>/dev/null'

# -------------------- Performance Fixes -------------------- #

# Fix for slow zsh-autosuggestions copy/paste
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Disable paste highlighting for performance
zle_highlight+=(paste:none)

# -------------------- Environment Variables -------------------- #

# Terminal configuration
export TERM="${TERM:-xterm-256color}"
export COLORTERM="${COLORTERM:-truecolor}"

# Editor configuration
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-$EDITOR}"

# Pager configuration
export PAGER="${PAGER:-less}"
export LESS="${LESS:--R -M --shift 5}"

# System detection
if [[ -f /etc/os-release ]]; then
    export DISTRO=$(grep -oP '^ID=\K.*' /etc/os-release 2>/dev/null || echo "unknown")
else
    export DISTRO="unknown"
fi

# Path enhancements
typeset -U path PATH
path=(
    "$HOME/.local/bin"
    "$HOME/bin"
    /usr/local/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
    $path
)

# -------------------- Aliases -------------------- #

# Detect bat command variant
if command_exists batcat; then
    alias cat="batcat"
    alias c="batcat -n"
    alias catp="batcat --plain"
    alias cdiff="batcat --diff"
elif command_exists bat; then
    alias cat="bat"
    alias c="bat -n"
    alias catp="bat --plain"
    alias cdiff="bat --diff"
fi

# Core aliases
alias sudo="sudo "
alias s="sudo "

# Network utilities
alias locip="hostname -I | awk '{print \$1}'"
alias pubip="curl -s https://ip.shardbyte.com 2>/dev/null && echo || echo 'Failed to get public IP'"

# File operations
alias mkdir="mkdir -p"
alias cl='clear'
alias l='ls -lh'
alias la='ls -la'
alias lla='ls -lha'
alias ll='ls -alF'
alias tree='tree -C'

# Safety aliases
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rmf="rm -rf"

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -='cd -'

# Enhanced commands
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias df='df -h'
alias du='du -h -c'
alias free='free -h'
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# Docker aliases (if docker is available)
if command_exists docker; then
    alias dkl='docker logs --follow'
    alias dkr='docker restart'
    alias dks='docker stop'
    alias dkps='docker ps'
    alias dkpsa='docker ps -a'
    alias dki='docker images'
    alias dkrmi='docker rmi'
    alias dkrm='docker rm'
    alias dke='docker exec -it'
fi

# Git aliases (enhanced)
if command_exists git; then
    alias gst='git status'
    alias gd='git diff'
    alias gdc='git diff --cached'
    alias gl='git log --oneline --graph --decorate --all'
    alias gco='git checkout'
    alias gcb='git checkout -b'
    alias gp='git push'
    alias gpl='git pull'
    alias ga='git add'
    alias gc='git commit'
    alias gcm='git commit -m'
fi

# System-specific aliases
case "$DISTRO" in
    debian|ubuntu)
        alias install='sudo apt install'
        alias update='sudo apt update && sudo apt upgrade'
        alias search='apt search'
        alias show='apt show'
        ;;
    fedora|rhel|centos)
        alias install='sudo dnf install'
        alias update='sudo dnf update'
        alias search='dnf search'
        alias show='dnf info'
        ;;
    arch|manjaro)
        alias install='sudo pacman -S'
        alias update='sudo pacman -Syu'
        alias search='pacman -Ss'
        alias show='pacman -Si'
        ;;
esac

# -------------------- Custom Functions -------------------- #

# Quick directory creation and navigation
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find process by name
psfind() {
    ps aux | grep -i "$1" | grep -v grep
}

# Quick weather check (if curl is available)
weather() {
    local location="${1:-}"
    if command_exists curl; then
        curl -s "wttr.in/$location?format=3"
    else
        echo "curl not available for weather check"
    fi
}

# -------------------- Shell Integration -------------------- #

# Change default shell to zsh if not already set
change_shell_to_zsh() {
    if [[ "$SHELL" != "$(which zsh)" ]] && command_exists zsh; then
        log "INFO" "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
    fi
}

# -------------------- Initialization -------------------- #

# Main initialization function
init_zsh_config() {
    # Set locale first
    set_locale
    
    # Install oh-my-zsh if needed
    install_oh_my_zsh
    
    # Setup plugins and themes
    setup_plugins
    
    # Export ZSH path
    export ZSH="$OH_MY_ZSH_DIR"
    
    # Source oh-my-zsh
    safe_source "$ZSH/oh-my-zsh.sh"
    
    # Source plugins manually (for reliability)
    safe_source "$ZSH_CUSTOM_DIR/plugins/fzf-tab/fzf-tab.plugin.zsh"
    safe_source "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    safe_source "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    
    # Change shell if needed
    change_shell_to_zsh
}

# -------------------- Cleanup -------------------- #

# Clean up old zshrc backup if it exists
cleanup_old_config() {
    local backup_file="$HOME/.zshrc.pre-oh-my-zsh"
    if [[ -f "$backup_file" ]]; then
        log "INFO" "Removing old zshrc backup"
        rm -f "$backup_file"
    fi
}

# -------------------- Final Initialization -------------------- #

# Initialize everything
init_zsh_config
cleanup_old_config

# Load any local customizations
safe_source "$HOME/.zshrc.local"

# Performance: compile zshrc for faster loading
if [[ ! -f "$HOME/.zshrc.zwc" || "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc" ]]; then
    zcompile "$HOME/.zshrc" 2>/dev/null || true
fi

######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
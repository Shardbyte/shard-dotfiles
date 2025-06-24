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
# ----- Shardbyte ZSH Theme v2.0 -----

# -------------------- Performance & Configuration -------------------- #

# Theme version and settings
readonly SHARDBYTE_THEME_VERSION="2.0.0"
readonly SHARDBYTE_SHOW_TIME=${SHARDBYTE_SHOW_TIME:-true}
readonly SHARDBYTE_SHOW_IP=${SHARDBYTE_SHOW_IP:-true}
readonly SHARDBYTE_SHOW_LOAD=${SHARDBYTE_SHOW_LOAD:-false}
readonly SHARDBYTE_ASYNC_PROMPT=${SHARDBYTE_ASYNC_PROMPT:-true}

# Performance: Cache expensive operations
typeset -g _shardbyte_ip_cache=""
typeset -g _shardbyte_ip_cache_time=0

# -------------------- Color Definitions -------------------- #

# Modern color palette using 256-color support
typeset -A SHARDBYTE_COLORS
SHARDBYTE_COLORS=(
    # Primary colors
    [primary]='%F{33}'          # Bright blue
    [secondary]='%F{129}'       # Bright magenta
    [accent]='%F{214}'          # Orange
    [success]='%F{82}'          # Bright green
    [warning]='%F{226}'         # Bright yellow
    [error]='%F{196}'           # Bright red
    [muted]='%F{241}'           # Dark grey
    [text]='%F{255}'            # White
    [reset]='%f%b'              # Reset
    
    # Status colors
    [git_clean]='%F{82}'        # Green
    [git_dirty]='%F{196}'       # Red
    [git_staged]='%F{226}'      # Yellow
    [git_untracked]='%F{208}'   # Orange
    
    # Background colors for better contrast
    [bg_error]='%K{52}'         # Dark red background
    [bg_success]='%K{22}'       # Dark green background
    [bg_warning]='%K{58}'       # Dark yellow background
)

# -------------------- Utility Functions -------------------- #

# Get current IP with caching (5 minute cache)
_shardbyte_get_ip() {
    local current_time=$(date +%s)
    local cache_duration=300  # 5 minutes
    
    if [[ -n "$_shardbyte_ip_cache" && $((current_time - _shardbyte_ip_cache_time)) -lt $cache_duration ]]; then
        echo "$_shardbyte_ip_cache"
        return
    fi
    
    local ip
    if command -v hostname >/dev/null 2>&1; then
        ip=$(hostname -I 2>/dev/null | awk '{print $1}')
    elif command -v ip >/dev/null 2>&1; then
        ip=$(ip route get 1 2>/dev/null | awk '{print $7; exit}')
    elif [[ -f /proc/net/route ]]; then
        ip=$(awk '/^0000/ {print $3}' /proc/net/route 2>/dev/null | head -1)
    fi
    
    if [[ -n "$ip" && "$ip" != "127.0.0.1" ]]; then
        _shardbyte_ip_cache="$ip"
        _shardbyte_ip_cache_time="$current_time"
        echo "$ip"
    else
        echo "N/A"
    fi
}

# Get system load average
_shardbyte_get_load() {
    if [[ -f /proc/loadavg ]]; then
        local load=$(cut -d' ' -f1 /proc/loadavg 2>/dev/null)
        if [[ -n "$load" ]]; then
            # Color code based on load
            if (( $(echo "$load > 2.0" | bc -l 2>/dev/null || echo 0) )); then
                echo "${SHARDBYTE_COLORS[error]}⚡$load${SHARDBYTE_COLORS[reset]}"
            elif (( $(echo "$load > 1.0" | bc -l 2>/dev/null || echo 0) )); then
                echo "${SHARDBYTE_COLORS[warning]}⚡$load${SHARDBYTE_COLORS[reset]}"
            else
                echo "${SHARDBYTE_COLORS[success]}⚡$load${SHARDBYTE_COLORS[reset]}"
            fi
        fi
    fi
}

# Enhanced git status with more detailed information
_shardbyte_git_status() {
    local git_status=""
    local git_info=""
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        return 0
    fi
    
    # Get basic git info
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    
    if [[ -z "$branch" ]]; then
        return 0
    fi
    
    # Check repository status
    local status_output
    status_output=$(git status --porcelain 2>/dev/null)
    
    local staged=0 modified=0 untracked=0 deleted=0
    
    while IFS= read -r line; do
        case "${line:0:2}" in
            'A '|'M '|'D '|'R '|'C ') ((staged++)) ;;
            ' M'|' D') ((modified++)) ;;
            '??') ((untracked++)) ;;
            ' D'|'D ') ((deleted++)) ;;
        esac
    done <<< "$status_output"
    
    # Build status string
    local status_parts=()
    [[ $staged -gt 0 ]] && status_parts+="${SHARDBYTE_COLORS[git_staged]}●$staged"
    [[ $modified -gt 0 ]] && status_parts+="${SHARDBYTE_COLORS[warning]}●$modified"
    [[ $deleted -gt 0 ]] && status_parts+="${SHARDBYTE_COLORS[error]}●$deleted"
    [[ $untracked -gt 0 ]] && status_parts+="${SHARDBYTE_COLORS[git_untracked]}●$untracked"
    
    # Check if repository is clean
    local clean_status=""
    if [[ ${#status_parts[@]} -eq 0 ]]; then
        clean_status=" ${SHARDBYTE_COLORS[git_clean]}✔"
    else
        clean_status=" ${SHARDBYTE_COLORS[git_dirty]}✗"
    fi
    
    # Check for upstream status
    local upstream_status=""
    local ahead_behind
    ahead_behind=$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
    if [[ -n "$ahead_behind" ]]; then
        local behind=$(echo "$ahead_behind" | cut -f1)
        local ahead=$(echo "$ahead_behind" | cut -f2)
        
        [[ $ahead -gt 0 ]] && upstream_status+="${SHARDBYTE_COLORS[primary]}↑$ahead"
        [[ $behind -gt 0 ]] && upstream_status+="${SHARDBYTE_COLORS[secondary]}↓$behind"
    fi
    
    # Combine all parts
    git_info="${SHARDBYTE_COLORS[primary]}‹${SHARDBYTE_COLORS[text]}$branch"
    [[ -n "$upstream_status" ]] && git_info+=" $upstream_status"
    [[ ${#status_parts[@]} -gt 0 ]] && git_info+=" ${status_parts[*]}"
    git_info+="$clean_status${SHARDBYTE_COLORS[primary]}›${SHARDBYTE_COLORS[reset]}"
    
    echo "$git_info"
}

# Enhanced virtualenv prompt
_shardbyte_virtualenv_prompt() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        echo " ${SHARDBYTE_COLORS[accent]}‹${SHARDBYTE_COLORS[text]}$venv_name${SHARDBYTE_COLORS[accent]}›${SHARDBYTE_COLORS[reset]}"
    fi
}

# Docker context prompt
_shardbyte_docker_prompt() {
    if command -v docker >/dev/null 2>&1 && [[ -n "$DOCKER_CONTEXT" && "$DOCKER_CONTEXT" != "default" ]]; then
        echo " ${SHARDBYTE_COLORS[primary]}🐳$DOCKER_CONTEXT${SHARDBYTE_COLORS[reset]}"
    fi
}

# Kubernetes context prompt
_shardbyte_k8s_prompt() {
    if command -v kubectl >/dev/null 2>&1 && kubectl config current-context >/dev/null 2>&1; then
        local context=$(kubectl config current-context 2>/dev/null)
        if [[ -n "$context" && "$context" != "docker-desktop" ]]; then
            echo " ${SHARDBYTE_COLORS[secondary]}⎈$context${SHARDBYTE_COLORS[reset]}"
        fi
    fi
}

# SSH connection indicator
_shardbyte_ssh_prompt() {
    if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" || "$USER" == "root" ]]; then
        echo " ${SHARDBYTE_COLORS[warning]}🔗${SHARDBYTE_COLORS[reset]}"
    fi
}

# Command execution time (requires precmd hook)
_shardbyte_exec_time() {
    if [[ -n "$_shardbyte_cmd_start_time" ]]; then
        local end_time=$(date +%s.%3N)
        local duration=$(echo "scale=3; $end_time - $_shardbyte_cmd_start_time" | bc 2>/dev/null)
        
        if [[ -n "$duration" ]] && (( $(echo "$duration > 1.0" | bc -l 2>/dev/null || echo 0) )); then
            local time_display
            if (( $(echo "$duration > 60" | bc -l 2>/dev/null || echo 0) )); then
                time_display=$(printf "%.0fm%.0fs" $((duration/60)) $((duration%60)))
            else
                time_display=$(printf "%.2fs" "$duration")
            fi
            echo " ${SHARDBYTE_COLORS[muted]}⏱$time_display${SHARDBYTE_COLORS[reset]}"
        fi
    fi
}

# -------------------- Prompt Components -------------------- #

# Main prompt components
_shardbyte_user_host() {
    local user_color host_color
    
    # Color coding for different user types
    if [[ $EUID -eq 0 ]]; then
        user_color="${SHARDBYTE_COLORS[error]}"
        host_color="${SHARDBYTE_COLORS[error]}"
    elif [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
        user_color="${SHARDBYTE_COLORS[warning]}"
        host_color="${SHARDBYTE_COLORS[warning]}"
    else
        user_color="${SHARDBYTE_COLORS[success]}"
        host_color="${SHARDBYTE_COLORS[primary]}"
    fi
    
    echo "%B${user_color}%n${SHARDBYTE_COLORS[muted]}@${host_color}%m${SHARDBYTE_COLORS[reset]}"
}

_shardbyte_current_dir() {
    # Truncate long paths
    local current_dir="%B${SHARDBYTE_COLORS[secondary]}%(5~|…/%3~|%~)${SHARDBYTE_COLORS[reset]}"
    echo "$current_dir"
}

_shardbyte_prompt_symbol() {
    local symbol
    if [[ $EUID -eq 0 ]]; then
        symbol="»"
    else
        symbol="➤"
    fi
    echo "%B${SHARDBYTE_COLORS[primary]}$symbol%b${SHARDBYTE_COLORS[reset]}"
}

_shardbyte_return_status() {
    echo "%(?..${SHARDBYTE_COLORS[bg_error]} %? ${SHARDBYTE_COLORS[reset]} )"
}

# -------------------- Right Prompt Components -------------------- #

_shardbyte_right_prompt() {
    local parts=()
    
    # Add execution time
    local exec_time=$(_shardbyte_exec_time)
    [[ -n "$exec_time" ]] && parts+=("$exec_time")
    
    # Add system load if enabled
    if [[ "$SHARDBYTE_SHOW_LOAD" == "true" ]]; then
        local load=$(_shardbyte_get_load)
        [[ -n "$load" ]] && parts+=("$load")
    fi
    
    # Add time if enabled
    if [[ "$SHARDBYTE_SHOW_TIME" == "true" ]]; then
        parts+=("${SHARDBYTE_COLORS[muted]}%D{%H:%M:%S}${SHARDBYTE_COLORS[reset]}")
    fi
    
    # Add IP if enabled
    if [[ "$SHARDBYTE_SHOW_IP" == "true" ]]; then
        local ip=$(_shardbyte_get_ip)
        [[ "$ip" != "N/A" ]] && parts+=("${SHARDBYTE_COLORS[muted]}$ip${SHARDBYTE_COLORS[reset]}")
    fi
    
    # Join parts with separator
    local separator=" ${SHARDBYTE_COLORS[muted]}│${SHARDBYTE_COLORS[reset]} "
    echo "${(j[$separator])parts}"
}

# -------------------- Hooks -------------------- #

# Pre-command hook for timing
_shardbyte_preexec() {
    _shardbyte_cmd_start_time=$(date +%s.%3N)
}

# Pre-command display hook
_shardbyte_precmd() {
    # Clear start time after command completion
    unset _shardbyte_cmd_start_time
    
    # Update terminal title
    print -Pn "\e]0;%n@%m: %~\a"
}

# Register hooks
autoload -Uz add-zsh-hook
add-zsh-hook preexec _shardbyte_preexec
add-zsh-hook precmd _shardbyte_precmd

# -------------------- Prompt Assembly -------------------- #

# Build main prompt
PROMPT='╭─$(_shardbyte_return_status)$(_shardbyte_user_host) $(_shardbyte_current_dir)$(_shardbyte_git_status)$(_shardbyte_virtualenv_prompt)$(_shardbyte_docker_prompt)$(_shardbyte_k8s_prompt)$(_shardbyte_ssh_prompt)
╰─$(_shardbyte_prompt_symbol) '

# Build right prompt
RPROMPT='$(_shardbyte_right_prompt)'

# -------------------- Legacy Compatibility -------------------- #

# Maintain compatibility with oh-my-zsh git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="${SHARDBYTE_COLORS[primary]}‹${SHARDBYTE_COLORS[text]}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${SHARDBYTE_COLORS[primary]}›${SHARDBYTE_COLORS[reset]}"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${SHARDBYTE_COLORS[git_dirty]}✗${SHARDBYTE_COLORS[reset]}"
ZSH_THEME_GIT_PROMPT_CLEAN=" ${SHARDBYTE_COLORS[git_clean]}✔${SHARDBYTE_COLORS[reset]}"
ZSH_THEME_GIT_PROMPT_ADDED="${SHARDBYTE_COLORS[git_staged]}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="${SHARDBYTE_COLORS[warning]}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="${SHARDBYTE_COLORS[error]}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="${SHARDBYTE_COLORS[primary]}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="${SHARDBYTE_COLORS[secondary]}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="${SHARDBYTE_COLORS[git_untracked]}◒ "

# Ruby prompt settings
ZSH_THEME_RUBY_PROMPT_PREFIX="${SHARDBYTE_COLORS[error]}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›${SHARDBYTE_COLORS[reset]}"
ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

# Mercurial prompt settings
ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

# Virtual environment prompt settings
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="${SHARDBYTE_COLORS[accent]}‹${SHARDBYTE_COLORS[text]}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="${SHARDBYTE_COLORS[accent]}›${SHARDBYTE_COLORS[reset]}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"

######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
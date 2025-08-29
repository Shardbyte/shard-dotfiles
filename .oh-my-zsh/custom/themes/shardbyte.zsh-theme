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
# ----- Shardbyte ZSH Theme -----
#
# Note: This theme uses ZSH prompt expansion sequences for reliable color handling
#

# -------------------- Prompt Reset Function -------------------- #
shardbyte_prompt_reset() {
    # Reset any lingering formatting and ensure clean terminal state
    printf '\033[0m\033[?25h'
    # Clear any potential line drawing artifacts
    printf '\033[2K\r'
}

# -------------------- Prompt Variables -------------------- #
local return_code="%(?..%F{#ed8796}%? ↵%f)"
local user_host="%B%(!.%F{#ed8796}.%F{#c6a0f6})%n@%m%f "
local user_symbol='%(!.󰘳.%F{#c6a0f6}󰅂%f)'
local current_dir="%B%F{#8bd5ca}%~%f%b "
local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'

# -------------------- Prompt Format Settings -------------------- #
# Ensure proper spacing and color reset
PROMPT="╭─${user_host}${current_dir}${vcs_branch}
╰─${user_symbol} ${return_code}"
RPROMPT="%F{#c6a0f6}󰌾%f %F{#8bd5ca}\$(hostname -I | awk '{print \$1}')%f"

# -------------------- Git Prompt Settings -------------------- #
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#8bd5ca}󰊢 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{#c6a0f6}󰊚%f"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{#a6da95}󰄴%f"
ZSH_THEME_GIT_PROMPT_ADDED="%F{#a6da95}󰐕%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{#c6a0f6}󰤌%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{#ed8796}󰆴%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{#8bd5ca}󰁔%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{#c6a0f6}󰞇%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{#cad3f5}󰋗%f"

# -------------------- Hooks -------------------- #
autoload -U add-zsh-hook
add-zsh-hook precmd shardbyte_prompt_reset

# -------------------- Additional Safety -------------------- #
# Ensure terminal supports required features
if [[ -z "$TERM" || "$TERM" == "dumb" ]]; then
    export TERM="xterm-256color"
fi
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
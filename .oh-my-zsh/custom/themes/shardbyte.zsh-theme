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
# ----- Enhanced Shardbyte ZSH Theme with 256 Colors -----
#
#
#
#
# -------------------- 256 Color Support -------------------- #
# Enable 256 color support
autoload -U colors && colors

# Define 256 color palette for consistent theming
typeset -A color256
color256[red]="%F{196}"
color256[green]="%F{46}"
color256[blue]="%F{39}"
color256[magenta]="%F{201}"
color256[cyan]="%F{51}"
color256[yellow]="%F{226}"
color256[orange]="%F{208}"
color256[purple]="%F{129}"
color256[grey]="%F{240}"
color256[light_grey]="%F{248}"
color256[dark_grey]="%F{236}"
color256[white]="%F{255}"
color256[reset]="%f"

# -------------------- Variables -------------------- #
local return_code="%(?..${color256[magenta]}%? ↵${color256[reset]})"
local user_host="%B%(!.${color256[red]}.${color256[green]})%n@%m${color256[reset]} "
local user_symbol='%(!.».➤)'
local current_dir="%B${color256[magenta]}%~ ${color256[reset]}"
local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

# Enhanced time display with better formatting
local time_display="${color256[white]}%D{%H:%M:%S}${color256[reset]}"

# Enhanced IP display with error handling
local ip_display='$(timeout 0.1 hostname -I 2>/dev/null | awk "{print \$1}" | head -1 || echo "no-ip")'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

# -------------------- Prompt Format Settings-------------------- #
PROMPT="╭─${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}
╰─%B${user_symbol}%b "
RPROMPT="${time_display} UTC ${color256[orange]}${color256[reset]} ${color256[white]}${ip_display}${color256[reset]} ${return_code}"

# -------------------- Enhanced Git Prompt Settings -------------------- #
ZSH_THEME_GIT_PROMPT_PREFIX="${color256[green]}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› ${color256[reset]}"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${color256[red]}✗${color256[reset]}"
ZSH_THEME_GIT_PROMPT_CLEAN=" ${color256[green]}✔${color256[reset]}"
ZSH_THEME_GIT_PROMPT_ADDED="${color256[green]}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="${color256[yellow]}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="${color256[red]}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="${color256[blue]}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="${color256[cyan]}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="${color256[white]}◒ "
ZSH_THEME_GIT_PROMPT_STASHED="${color256[purple]}⚆ "

# -------------------- Enhanced Ruby Prompt Settings -------------------- #
ZSH_THEME_RUBY_PROMPT_PREFIX="${color256[grey]}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› ${color256[reset]}"

# -------------------- HG Prompt Settings -------------------- #
ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

# -------------------- Enhanced VirtualENV Prompt Settings -------------------- #
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="${color256[green]}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› ${color256[reset]}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"

# -------------------- Performance Optimizations -------------------- #
# Cache expensive operations
typeset -g _shardbyte_git_status_cache=""
typeset -g _shardbyte_git_status_time=0


#
#
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
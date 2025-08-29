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
#
#
#
# -------------------- Color Variables -------------------- #
local color_purple='%{%F{#c6a0f6}%}'      # Purple/Mauve
local color_green='%{%F{#a6da95}%}'       # Green
local color_yellow='%{%F{#eed49f}%}'      # Yellow
local color_cyan='%{%F{#8bd5ca}%}'        # Teal/Cyan
local color_blue='%{%F{#8aadf4}%}'        # Blue
local color_red='%{%F{#ed8796}%}'         # Red
local color_white='%{%F{#cad3f5}%}'       # Text White
local color_reset='%{%f%}'
# -------------------- Variables -------------------- #
local return_code="%(?..${color_red}%? ↵${color_reset})"
local user_host="%B%(!.${color_red}.${color_purple})%n@%m${color_reset} "
local user_symbol='%(!.󰘳.${color_purple}󰅂${color_reset})'
local current_dir="%B${color_cyan}%~ ${color_reset}"
local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'

# -------------------- Prompt Format Settings-------------------- #
PROMPT="╭─${user_host}${current_dir}${vcs_branch}
╰─%B${user_symbol}%b ${return_code}"
RPROMPT="${color_purple}󰌾 ${color_cyan}$(hostname -I | awk '{print $1}') ${color_reset}"


# -------------------- Git Prompt Settings -------------------- #
ZSH_THEME_GIT_PROMPT_PREFIX="${color_cyan}󰊢 "
ZSH_THEME_GIT_PROMPT_SUFFIX=" ${color_reset}"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${color_purple}󰊚${color_reset}"
ZSH_THEME_GIT_PROMPT_CLEAN=" ${color_green}󰄴${color_reset}"
ZSH_THEME_GIT_PROMPT_ADDED="${color_green}󰐕 "
ZSH_THEME_GIT_PROMPT_MODIFIED="${color_purple}󰤌 "
ZSH_THEME_GIT_PROMPT_DELETED="${color_red}󰆴 "
ZSH_THEME_GIT_PROMPT_RENAMED="${color_cyan}󰁔 "
ZSH_THEME_GIT_PROMPT_UNMERGED="${color_purple}󰞇 "
ZSH_THEME_GIT_PROMPT_UNTRACKED="${color_white}󰋗 "
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
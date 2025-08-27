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
local color_purple='%{\e[38;2;198;160;246m%}'      # Purple/Mauve
local color_green='%{\e[38;2;166;218;149m%}'       # Green
local color_yellow='%{\e[38;2;238;212;159m%}'      # Yellow
local color_cyan='%{\e[38;2;139;213;202m%}'        # Teal/Cyan
local color_blue='%{\e[38;2;138;173;244m%}'        # Blue
local color_red='%{\e[38;2;237;135;150m%}'         # Red
local color_white='%{\e[38;2;202;211;245m%}'       # Text White
local color_reset='%{$reset_color%}'
# -------------------- Variables -------------------- #
local return_code="%(?..${color_red}%? ↵${color_reset})"
local user_host="%B%(!.${color_red}.${color_purple})%n@%m${color_reset} "
local user_symbol='%(!.󰘳.${color_purple}󰅂${color_reset})'
local current_dir="%B${color_cyan}%~ ${color_reset}"
local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'

# -------------------- Prompt Format Settings-------------------- #
PROMPT="╭─${user_host}${current_dir}${vcs_branch}
╰─%B${user_symbol}%b ${return_code}"
RPROMPT="${color_green}⚡ ${color_purple}󰌾 ${color_cyan}$(hostname -I | awk '{print $1}') ${color_reset}"


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
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


# -------------------- Variables -------------------- #
local return_code="%(?..%{$fg[magenta]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local user_symbol='%(!.󰶻.)'
local current_dir="%B%{$fg[magenta]%}%󰉋 %{$reset_color%}"

local vcs_branch='$(git_prompt_info)'
# -------------------- Prompt Format Settings-------------------- #
PROMPT="╭─${user_host}${current_dir}
╰─%B${user_symbol}%b "
RPROMPT="%{$fg[green]%}󰌾  %{$fg[magenta]%}$(hostname -I | awk '{print $1}') %{$reset_color%}"
# -------------------- Git Prompt Settings -------------------- #
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[magenta]%}󰃤%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}󰨮%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}󰗨 "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[cyan]%}󰁕 "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}󰞇 "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}󱗽 "
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
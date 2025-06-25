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
local user_symbol='%(!.».➤)'
local current_dir="%B%{$fg[magenta]%}%~ %{$reset_color%}"


local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"


# -------------------- Prompt Format Settings-------------------- #
PROMPT="╭─${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%W %t UTC    $(hostname -I | awk '{print $1}') %{$reset_color%}"


# -------------------- Git Prompt Settings -------------------- #
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "


# -------------------- Ruby Prompt Settings -------------------- #
ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[grey]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"


# -------------------- HG Prompt Settings -------------------- #
ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"


# -------------------- VirtialENV Prompt Settings -------------------- #
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
#
#
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
# fino.zsh-theme

# Use with a dark background and 256-color terminal!
# Meant for people with rbenv and git. Tested only on OS X 10.7.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

function virtualenv_prompt_info {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}

function prompt_char {
  command git branch &>/dev/null && echo "±" || echo '○'
}

function box_name {
  local box="${SHORT_HOST:-$HOST}"
  [[ -f ~/.box-name ]] && box="$(< ~/.box-name)"
  echo "${box:gs/%/%%}"
}

local ruby_env='$(ruby_prompt_info)'
local git_info='$(git_prompt_info)'
local virtualenv_info='$(virtualenv_prompt_info)'
local prompt_char='$(prompt_char)'

PROMPT="${FG[032]}╭─${FG[042]}%n%{$reset_color%}@${FG[042]}$(box_name)%{$reset_color%}:${FG[032]}%~%{$reset_color%}${git_info}${ruby_env}${virtualenv_info}
${FG[032]}╰─${prompt_char}%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[042]}on%{$reset_color%} ${FG[255]}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[204]}✘✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN="${FG[042]}✔"

ZSH_THEME_RUBY_PROMPT_PREFIX=" ${FG[042]}using${FG[243]} ‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[042]}using${FG[228]} «"
ZSH_THEME_VIRTUALENV_SUFFIX="»%{$reset_color%}"

# My lambda theme with green lambda and limit current dir length
PROMPT='%{$fg_bold[green]%}λ%{$reset_color%} ${_current_dir} $(git_prompt_info)%{$reset_color%}'

local _current_dir="%3~"

function _current_dir() {
  local _max_pwd_length="65"
  if [[ $(echo -n $PWD | wc -c) -gt ${_max_pwd_length} ]]; then
    echo "%-2~ ... %3~"
  else
    echo "%~"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "

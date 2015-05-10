if [ "$USER" = "root" ]
then CARETCOLOR="red"
else CARETCOLOR="blue"
fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function rvm_prompt_info() {
  [[ "${GEM_HOME:-}" == "" ]] && return 1
  echo "($(basename "${GEM_HOME:-}"))"
}

PROMPT='%{${fg_bold[red]}%}$(rvm_prompt_info)%{$reset_color%}\
%{${fg_bold[yellow]}%}$(virtualenv_prompt_info)%{$reset_color%}\
%m%{${fg_bold[magenta]}%} :: %{$reset_color%}%{${fg[green]}%}%3~ \
$(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}%#%{${reset_color}%} '

RPS1='$(vi_mode_prompt_info) ${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$reset_color%}%{$fg[magenta]%}<<%{$reset_color%}"

# TODO use 265 colors
#MODE_INDICATOR="$FX[bold]$FG[020]<$FX[no_bold]%{$fg[blue]%}<<%{$reset_color%}"
# TODO use two lines if git
# vim: ft=zsh

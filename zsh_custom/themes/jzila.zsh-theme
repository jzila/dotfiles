PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%M %* %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%(!.#.➜)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}*%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

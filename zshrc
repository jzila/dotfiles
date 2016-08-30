# Path to your oh-my-zsh configuration.
if [ ! -e "$HOME/.oh-my-zsh" ]; then
    git clone git@github.com:jzila/oh-my-zsh.git $HOME/.oh-my-zsh
fi
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jzila"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode svn history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/go/bin:$HOME/bin
export LD_LIBRARY_PATH=/usr/local/lib

alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='ls -l'
alias la='ls -la'
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'

alias livelock='ssh jzila@192.241.238.163'

alias grep='grep -I --exclude-dir="*\.svn*" --exclude="*\.svn-base"'
alias grepnolog='grep -I --exclude-dir="*log*" --exclude-dir="*\.svn*" --exclude="*\.svn-base"'


alias gup='git fetch origin && git rebase origin/master'
alias gp='git push -u origin'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gr='git rebase'
alias grm='git rebase origin/master'

alias sift='sift --binary-skip'

bindkey -v

unset correctall
set correct

export PATH="/usr/local/heroku/bin:$PATH"
export GREP_OPTIONS='--color=auto --exclude="*.svn-base"'
export GREP_COLOR='1;31'
# export PORT=8084

### Prevent the shell from blocking a command with mismatched arguments
unsetopt nomatch 2>/dev/null

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export JZ_REPO="$HOME/repos/go/src/github.com/jzila"
export KB_REPO="$HOME/repos/go/src/github.com/keybase"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export GOPATH="$HOME/repos/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/apps/android-studio/bin:$PATH"

# echo the path relative to the root of the current repository, or the current
# directory if none can be found
repodir() {
    local old_pwd="$PWD"
    local counter="."
    while true; do
        local cur_pwd="$(echo -n $(cd $counter && pwd))"
        if [[ "$cur_pwd" == "/" ]]; then
            echo "${PWD##*/}"
            return 0
        fi
        for repo in "$cur_pwd/.git" "$cur_pwd/.hg"; do
            if [[ -d "$repo" ]]; then
                cur_pwd="$(echo -n $(cd ../$counter && pwd))"
                echo "${old_pwd#$cur_pwd/}"
                return 0
            fi
        done
        counter="../$counter"
    done
}

reporoot() {
    git rev-parse --show-toplevel
}

gopkgpath() {
    root=$(git rev-parse --show-toplevel)
    gopath=$(go env GOPATH)
    echo ${root##${gopath}/}
}

godocker() {
    docker run -it --net="host" -v $(reporoot):/go/$(gopkgpath) --entrypoint bash -w "/go/$(gopkgpath)" golang:1.7
}

indocker() {
    docker run -v $PWD:/home/foo -w "/home/foo" debian:jessie $@
}

itdocker() {
    docker run -it -v $PWD:/home/foo -w "/home/foo" debian:jessie $@
}

open_tunnel() {
    if [ "$1" ]; then
        PORT=2222
        REMOTE_PORT=22
        if [ "$2" ]; then
            PORT=$2
            if [ "$3" ]; then
                REMOTE_PORT=$3
            fi
        fi
        ssh -L $PORT:$1:$REMOTE_PORT jzila@gw.keybase.io
    else
        echo "No argument specified"
    fi
}

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%M %* %{$fg[cyan]%}$(repodir) %{$fg_bold[blue]%}$(git_prompt_info)%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%(!.#.➜)%{$fg_bold[blue]%} % %{$reset_color%}'

### Ensure that docker commands can be run
# if [[ "$(uname)" == 'Darwin' ]]; then
#     docker_env="$(docker-machine env default)"
#     if [[ "$?" != "0" ]]; then
#         docker-machine start default
#         docker_env="$(docker-machine env default)"
#     fi
#     eval $docker_env
# fi

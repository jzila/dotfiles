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
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

ZSH_AUTOSUGGEST_STRATEGY=(history)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode svn history-substring-search zsh-autosuggestions zsh-syntax-highlighting bgnotify)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' accept-exact-dirs true

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/go/bin:$HOME/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib
if [ "$(uname -s)" = "Darwin" ]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export KEYBASE_DEV_TOOL_ROOTS="$HOME/Library/Application Support/Google/Chrome/Profile 1/Extensions/fmkadmapgofadopljbjfkapdkoienihi,$HOME/Library/Application Support/Google/Chrome/Profile 1/Extensions/hgldghadipiblonfkkicmgcbbijnpeog"
else
    export ANDROID_HOME=$HOME/Android/sdk
fi
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"

alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='ls -l'
alias la='ls -la'
alias l1='ls -1'
alias l1a='ls -1a'
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
alias yubigw='yubikey gw'

alias livelock='ssh jzila@192.241.238.163'

alias grep='grep -I --exclude-dir=".git" --exclude-dir="vendor" --exclude-dir="node_modules" --exclude-dir=dist'
alias grepnolog='grep -I --exclude-dir="*log*" --exclude-dir="*\.svn*" --exclude="*\.svn-base"'


alias gup='git fetch origin && git rebase origin/master'
alias gds='git --no-pager diff --stat'
alias gp='git push'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gr='git rebase'
alias grm='git rebase origin/master'
alias ga='git add'
alias gaa='git add -A'

alias sift='sift --binary-skip'

bindkey -v

unset correctall
set correct

export GREP_COLOR='1;31'
# export PORT=8084

### Prevent the shell from blocking a command with mismatched arguments
unsetopt nomatch 2>/dev/null

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export PATH="$PATH:$HOME/.yarn/bin"

export JZ_REPO="$HOME/repos/go/src/github.com/jzila"
export KB_REPO="$HOME/repos/go/src/github.com/keybase"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH="$HOME/repos/go"
export PATH="$PATH:$GOPATH/bin"

export RUN_MODE=devel

unset KEYBASE_PERF
export KEYBASE_LOCAL_DEBUG=1
export KEYBASE_FEATURES="admin"

# echo the path relative to the root of the current repository, or the current
# directory if none can be found
repodir() {
    local old_pwd="$PWD"
    local counter="."
    if [[ "${PWD##/keybase/}" != "$old_pwd" ]]; then
        echo "${PWD##*/}"
        return 0
    fi
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

gitprompt() {
    if [[ "${PWD##/keybase/}" != "$PWD" ]]; then
        return
    fi
    git_prompt_info "$@"
}

gopkgpath() {
    root=$(git rev-parse --show-toplevel)
    gopath=$(go env GOPATH)
    echo ${root##${gopath}/}
}

purge_old_kernels() {
    dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
}

dcleanup(){
	local containers
	containers=( $(docker ps -aq 2>/dev/null) )
	docker rm "${containers[@]}" 2>/dev/null
	local volumes
	volumes=( $(docker volume ls --filter dangling=true -q 2>/dev/null) )
	docker volume rm "${volumes[@]}" 2>/dev/null
	local images
	images=( $(docker images --filter dangling=true -q 2>/dev/null) )
	docker rmi "${images[@]}" 2>/dev/null
}

godocker() {
    docker run --rm -it --net="host" -v $(reporoot):/go/$(gopkgpath) --entrypoint bash -w "/go/$(gopkgpath)/../$(repodir)" golang:1.9.2
}

indocker() {
    docker run --rm -it -v $PWD:/home/foo -w "/home/foo" debian:jessie $@
}

yubikey() {
    if [ "$1" ]; then
        ykman oath code | grep "$1" | head -n 1 | awk '{print $NF}'
    else
        echo STDERR "Usage: yubikey <name of service>"
        return 1
    fi
}

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%M %* %{$fg[cyan]%}$(repodir) %{$fg_bold[blue]%}$(gitprompt)%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%(!.#.➜)%{$fg_bold[blue]%} % %{$reset_color%}'

# bun completions
[ -s "/home/john/.bun/_bun" ] && source "/home/john/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

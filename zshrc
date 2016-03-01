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
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/go/bin:/home/john/bin
export LD_LIBRARY_PATH=/usr/local/lib

export FLYNN_HOME=/home/john/repos/go/src/github.com/flynn/flynn



alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='ls -l'
alias la='ls -la'

alias livelock='ssh jzila@192.241.238.163'

alias grep='grep -I --exclude-dir="*\.svn*" --exclude="*\.svn-base"'
alias grepnolog='grep -I --exclude-dir="*log*" --exclude-dir="*\.svn*" --exclude="*\.svn-base"'


alias gup='git pull --rebase upstream master'
alias gp='git push -u origin'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gr='git rebase'

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

export JZ_REPO="/home/john/repos/go/src/github.com/jzila"
export KB_REPO="/home/john/repos/go/src/github.com/keybase"

[[ -s "/home/john/.gvm/scripts/gvm" ]] && source "/home/john/.gvm/scripts/gvm"

export GOPATH="/home/john/repos/go"
export GOROOT=
export PATH="$GOPATH/bin:$PATH"
export PATH="/home/john/apps/android-studio/bin:$PATH"

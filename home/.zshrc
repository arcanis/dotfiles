#!/usr/bin/env zsh

# Script directory.
if [[ $0 == "zsh" || $0 == "-zsh" ]]; then
    SCRIPT_NAME=${funcstack[1]}
    SCRIPT_PATH=${SCRIPT_NAME:A}
    SCRIPT_DIRECTORY=$(dirname "$SCRIPT_PATH")
else
    SCRIPT_PATH=$0:A
    SCRIPT_NAME=$(basename "$SCRIPT_PATH")
    SCRIPT_DIRECTORY=$(dirname "$SCRIPT_PATH")
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="arca"

# Automatically start tmux.
ZSH_TMUX_AUTOSTART="true"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git nvm nvm-auto tmux git-root fix-ssh)

# Start an SSH agent with the right id_rsa if we're inside a Bash On Windows environment
[[ -e /mnt/c/Users/Mael/Documents/id_rsa ]] && eval $(ssh-agent) >& /dev/null && ssh-add /mnt/c/Users/Mael/Documents/id_rsa >& /dev/null

# Finally load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Language environment
export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='emacs -nw'

# Remove oh-my-zsh aliases.
unalias -m '*'

# Add back some useful aliases.
alias /='git_root'
alias ../..='cd ../..'
alias ../../..='cd ../../..'
alias ../../../..='cd ../../../..'

# Set personal aliases.
alias emacs='emacs -nw'
alias ne='emacs'
alias sudo='sudo -E'
alias ls='LC_ALL=C ls --color=auto --group-directories-first -X'
alias ll='ls -lh'
alias la='ll -a'
alias rm='rm -I'
alias sprunge='curl -F "sprunge=<-" http://sprunge.us'
alias amend='git commit --amend --no-edit'

alias docker.bash="docker exec -ti docker_wisembly_1 /bin/bash"
alias docker.sql="docker exec -ti docker_db_1 mysql -uroot -proot wisembly_dev"
alias docker.resetdb="docker.bash -c 'cd api && ./bin/create_database.sh'"

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

# Custom plugins/themes paths.
ZSH_CUSTOM="$SCRIPT_DIRECTORY/oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="arca"

# Automatically start tmux.
ZSH_TMUX_AUTOSTART="true"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git nvm nvm-auto tmux)

# Finally load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Language environment
export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='emacs -nw'

# Remove oh-my-zsh aliases.
unalias -m '*'

# Set personal aliases.
alias emacs='emacs -nw'
alias ne='emacs'
alias sudo='sudo -E'
alias ls='LC_ALL=C ls --color=auto --group-directories-first -X'
alias ll='ls -lh'
alias rm='rm -I'
alias sprunge='curl -F "sprunge=<-" http://sprunge.us'

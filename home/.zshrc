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

# Coreutils on OSX
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Enables truecolors
export COLORTERM=truecolor

# Set name of the theme to load.
ZSH_THEME="arca"

# Automatically start tmux.
ZSH_TMUX_AUTOSTART="true"

# Automatically start tmux.
ZSH_TMUX_AUTOQUIT="false"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(tmux)

# Start an SSH agent with the right id_rsa if we're inside a Bash On Windows environment
[[ -e /mnt/c/Users/Mael/Documents/id_rsa ]] && eval $(ssh-agent) >& /dev/null && ssh-add /mnt/c/Users/Mael/Documents/id_rsa >& /dev/null

# Export the DISPLAY environment if we're inside a Bash On Windows environment
[[ -e /mnt/c ]] && export DISPLAY=localhost:0.0

# Links the utilities bundled with the dotfiles
export PATH="$SCRIPT_DIRECTORY"/../utils:"$PATH"

# Finally load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Add yn to the path
export PATH=~/yn/dist:"$PATH"

# Language environment
export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='emacs -nw'

# Remove oh-my-zsh aliases.
unalias -m '*'

# Add back some useful aliases.
alias /='git-root'
alias ../..='cd ../..'
alias ../../..='cd ../../..'
alias ../../../..='cd ../../../..'

# Set personal aliases.
alias emacs='emacs -nw'
alias ne='emacs'
alias sudo='sudo -E '
alias ls="LC_ALL=C ls --color=auto --group-directories-first -X"
alias ll='ls -lh'
alias la='ll -a'
alias rm='rm -I'
alias sprunge='curl -F "sprunge=<-" http://sprunge.us'
alias amend='git commit --amend --no-edit'
alias push='git push -u origin HEAD'

export DATADOG_ROOT="$HOME/dd"
export PATH="$PATH:$DATADOG_ROOT/devtools/bin"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

if [[ -e /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -e "$HOME/.zshrc.secret" ]]; then
    source "$HOME/.zshrc.secret"
fi

if (cd "$(realpath "$SCRIPT_DIRECTORY")" && ! git diff --exit-code "$(realpath "$SCRIPT_PATH")") >& /dev/null; then
    print -P "%B%F{red}Danger:%b%f The .zshrc file has been modified; check it doesn't contain tokens! If that's"
    print -P "        the case, move them to ~/.zshrc.secret then restart your shell."
fi

agent() {
    eval "$(ssh-agent -s)"
    ssh-add
    ssh -T git@github.com
}

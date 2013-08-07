#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Affiche une liste des paquets possibles quand une commande est absente
[[ -e /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash

# Nous forcons la vérification des dimensions de la fenêtre à chaque commande
shopt -s checkwinsize

# Définition des alias qui vont bien
alias sudo='sudo '
alias emacs='emacs -nw'
alias ne='emacs'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ll -A'
alias rm='rm -I'
alias gdb='gdb -q '
alias valgrind='valgrind -q '

# Quelques fonctions utiles
function irclog() {
    local pattern

    if [ -z "$4" ]; then
        pattern="$1_$2_*"
    else
        pattern="$1_$2_$4.log"
    fi

    sudo -u znc printf ""
    sudo -u znc find ~znc/.znc/users/"$3"/moddata/log -name "${pattern}" \
        | sort \
        | sudo -u znc xargs cat \
        | grep --color=always -P '^\[[0-9]{2}:[0-9]{2}:[0-9]{2}\].*arcanis.*|$' \
        | less -RS +G +F
}

function sprunge() {
    curl -F 'sprunge=<-' http://sprunge.us
}

# Génération du colorset de l'ordinateur (en fonction de son hostname)
COLOR_SCHEME=$(( echo -n '(0'; echo -n "${HOSTNAME}" | sed "s/\(.\)/'\1\d0/g" | xargs -0 printf "+%d-32" ; echo ')%7+1' ) | bc)
PROMPT_COLOR="\e[1;9${COLOR_SCHEME}m"
COMMAND_COLOR="\e[0;9${COLOR_SCHEME}m"

# Définition du prompt
export PS1=$(printf "%s\\\u@\\\w # %s" "\[${PROMPT_COLOR}\]" "\[${COMMAND_COLOR}\]")
trap 'tput sgr0' DEBUG

# Lancement automatique de Tmux
if [[ -z "${TMUX}" ]]; then
    tmux attach || tmux new
    [[ "$?" -eq 42 ]] && exit
fi

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Affiche une liste des paquets possibles quand une commande est absente
[[ -e /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash

# Nous forcons la vérification des dimensions de la fenêtre à chaque commande
shopt -s checkwinsize

# Markscript
. "$( cd "$( dirname "$( readlink -f "${BASH_SOURCE[0]}" )" )" && pwd )"/markscript.sh

# Définition des alias qui vont bien
alias sudo='sudo -E '
alias emacs='emacs -nw'
alias ne='emacs'
alias ls='ls --color=auto --group-directories-first -X'
alias ll='ls -lh'
alias la='ll -A'
alias rm='rm -I'
alias gdb='gdb -q '
alias valgrind='valgrind -q '
alias g='grep -PR'
alias w='watch '

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
        | grep --color=always -P '^\[[0-9]{2}:[0-9]{2}:[0-9]{2}\].*'"$3"'.*|$' \
        | less -RS +G +F
}

function sprunge() {
    curl -F 'sprunge=<-' http://sprunge.us
}

function findp() {
    local sed_tab=$(printf '%q' 's/\t/  /g')
    local sed_sep=$(printf '%q' 's/^\([^:]*\):[[:blank:]]*/\1\t/')
    local sed_trim=$(printf '%q' 's/[[:blank:]]*$//')

    local path=$(printf '%q' "$1")
    local pattern=$(printf '%q' "$2")

    w grep -PR $pattern $path \| sed $sed_tab \| sed $sed_sep \| sed $sed_trim \| column -t -s'"	"' \| cut -c-$COLUMNS
}

function serve() {
    php -S 0.0.0.0:${1-8080}
}

# Génération du colorset de l'ordinateur (en fonction de son hostname)
COLOR_SCHEME=$(( echo -n '(0'; echo -n "${HOSTNAME}" | sed "s/\(.\)/'\1\d0/g" | xargs -0 printf "+%d-32" ; echo ')%7+1' ) | bc)
PROMPT_COLOR="\e[1;9${COLOR_SCHEME}m"
COMMAND_COLOR="\e[0;9${COLOR_SCHEME}m"

# Définition du prompt
export PS1=$(printf "%s\\\u@\\\w # %s" "\[${PROMPT_COLOR}\]" "\[${COMMAND_COLOR}\]")
trap 'tput sgr0' DEBUG

# Désactive l'expansion de l'history
set +o histexpand

# Ordonne à bash d'ignorer les lignes dupliquées dans l'historique
HISTCONTROL=ignoredups

# Active l'expansion profonde (ex. **/*.js)
shopt -s globstar

# Défini l'éditeur que je préfère
export EDITOR="emacs -nw"

# Lancement automatique de Tmux
if [[ -z "${TMUX}" ]]; then
    tmux attach || tmux new
    [[ "$?" -eq 42 ]] && exit
fi

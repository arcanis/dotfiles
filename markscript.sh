MARKSPATH="$HOME/.marks/"

function jump {
    if [[ "$#" -lt 1 ]]; then
        echo "Usage: jump <mark>" >& 2
        return 1
    fi

    local mark="$1"

    if ! [[ "${mark##/*}" = "$mark" && "$mark" != "." && "$mark" != ".." ]]; then
        echo "jump: Bad mark name: $mark" >& 2
        return 1
    fi

    if [[ "$1" = "" ]]; then
        echo "jump: Mark names cannot be empty" >& 2
        return 1
    fi

    if ! [[ -e "$MARKSPATH"/"$mark" ]]; then
        echo "jump: No such mark: $mark" >& 2
        return 1
    fi

    cd -P "$MARKSPATH"/"$mark"

    if git rev-parse --git-dir >& /dev/null; then
        git status --branch --short
    fi
}

function mark {
    if [[ "$#" -lt 1 ]]; then
        echo "Usage: mark <mark>" >& 2
        return 1
    fi

    local mark="$1"
    local path="$(pwd)"

    if ! [[ "${mark##/*}" = "$mark" && "$mark" != "." && "$mark" != ".." ]]; then
        echo "mark: Bad mark name: $mark" >& 2
        return 1
    fi

    if [[ "$mark" = "" ]]; then
        echo "mark: Mark names cannot be empty" >& 2
        return 1
    fi

    mkdir -p "$MARKSPATH"
    ln -sf "$path" "$MARKSPATH"/"$mark"
    echo "« $mark » marked."
}

function unmark {
    if [[ "$#" -lt 1 ]]; then
        local mark="$(find "$MARKSPATH" -lname "$(pwd)" -exec basename {} \;)"

        if [[ "$mark" = "" ]]; then
            echo "unmark: Current directory doesn't have any mark" >& 2
            return 1
        fi
    else
        local mark="$1"
    fi

    if ! [[ "${mark##/*}" = "$mark" && "$mark" != "." && "$mark" != ".." ]]; then
        echo "unmark: Bad mark name: $mark"
        return 1
    fi

    if [[ "$mark" = "" ]]; then
        echo "unmark: Marks name cannot be empty" >& 2
        return 1
    fi

    if [[ -e "$MARKSPATH"/"$mark" ]]; then
        rm -f "$MARKSPATH"/"$mark"
        echo "« $mark » unmarked."
    fi
}

function marks {
    echo "Current marks :"
    mkdir -p "$MARKSPATH"
    find "$MARKSPATH" -type l -print0 |
    while read -d $'\0' x; do
        printf "%s\t->\t%s\n" "$(basename "$x")" "$(readlink "$x")"
    done | column -t
}

function _mark_completion {
    [[ "$COMP_CWORD" -ne 1 ]] && return
    local cur=${COMP_WORDS[COMP_CWORD]}
    local marks=$(find "$MARKSPATH" -type l | awk -F '/' '{print $NF}')
    COMPREPLY=($(compgen -W '${marks[@]}' -- "$cur"))
    return 0
}

complete -o default -F _mark_completion jump
complete -o default -F _mark_completion unmark

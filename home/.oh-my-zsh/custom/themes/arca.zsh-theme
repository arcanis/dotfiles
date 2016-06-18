function theme_top_line() {

    print -P -- "${(r:$COLUMNS::─:)}"

}

function theme_bottom_line() {

    print -P -- ""

}

function theme_hostname() {

    local hostname=$(hostname)

    case "$hostname" in

        ubuntu)
            # Nothing
        ;;

        arcanis-fr|start9-io)
            print -n -- "%B%F{magenta}[$hostname]%f%b "
        ;;

        *)
            print -n -- "%B%F{white}[$hostname?]%f%b "
        ;;

    esac

}

function theme_location() {

    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?

    if [[ $ret == 0 ]]; then

        local fullrepo=$(git rev-parse --show-toplevel)
        local fullpwd=$(pwd)

        local repo=$(basename $fullrepo)
        local pwd=${fullpwd#"$fullrepo"}

        print -n -- "%F{yellow}$repo%F{cyan}$pwd%f"

    else

        print -n -- "%F{cyan}$(pwd | perl -pe 'chomp if eof')%f"

    fi

}

autoload -Uz add-zsh-hook

add-zsh-hook precmd theme_top_line
add-zsh-hook preexec theme_bottom_line

local theme_retcode="%B%(?:%F{green}❯:%F{red}❯)%f%b "
PROMPT='${theme_retcode}$(theme_hostname)$(theme_location) $(git_prompt_info)${theme_retcode}'

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{blue}git:(%F{red}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{blue})%b %F{yellow}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{blue})%b"

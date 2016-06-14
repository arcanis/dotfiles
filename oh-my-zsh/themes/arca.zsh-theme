function git_current_branch() {

    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?

    if [[ $ret == 0 ]]; then

        local fullrepo=$(git rev-parse --show-toplevel)
        local fullpwd=$(pwd)

        local repo=$(basename $fullrepo)
        local pwd=${fullpwd#"$fullrepo"}

        printf '%s%s' $repo $pwd

    else

        pwd

    fi

}

function theme_top_line() {

    print -P -- ${FG[238]}${(r:$COLUMNS::─:)}

}

function theme_bottom_line() {

    echo

}

autoload -Uz add-zsh-hook

add-zsh-hook precmd theme_top_line
add-zsh-hook preexec theme_bottom_line

local ret_status="%(?:%{$fg_bold[green]%}❯:%{$fg_bold[red]%}❯)%{$reset_color%}"
PROMPT='${ret_status} %{$fg[cyan]%}$(git_current_branch)%{$reset_color%} $(git_prompt_info)${ret_status} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

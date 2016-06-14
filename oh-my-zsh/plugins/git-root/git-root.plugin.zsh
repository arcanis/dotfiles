function git_root() {

    if command git symbolic-ref --quiet HEAD >& /dev/null; then
        cd "$(git rev-parse --show-toplevel)"
    else
        cd /
    fi

}

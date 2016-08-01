#!/usr/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target="$1"

if [[ -z "$target" ]]; then

    echo "Usage: $0 <Installation path>"
    exit 1

else

    target="$(cd "$target" ; pwd -P)"
    echo "Target is $target"

fi

while read path; do

    if [[ ! -z ${path// } ]]; then

        echo "Installing $path ..."

        if [[ -L "$target"/"$path" ]]; then
            rm -f "$target"/"$path"
        elif [[ -e "$target"/"$path" ]]; then
            rm -r "$target"/"$path"
        fi

        ln -s "$dir"/"home"/"$path" "$target"/"$path"

    fi

done <<EOF

    .emacs.d
    .emacs

    .inputrc
    .tmux.conf

    .oh-my-zsh/custom
    .zshrc

EOF

#!/usr/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

target="$1"
if [ -z "$target" ]; then
    echo "Usage: $0 <Installation path>"
    exit 1
else
    target="$(cd "$target" ; pwd -P)"
    echo "Target is $target"
fi

( cd "$dir" ; git ls-files ) | cut -f1 -d/ | uniq \
| while read file; do
    if [ "$file" \!= "install.sh" -a "$file" \!= "markscript.sh" ]; then
        echo "Installing $file ..."
        rm -rf "$target"/"$file"
        ln -s "$dir"/"$file" "$target"/"$file"
    fi
done

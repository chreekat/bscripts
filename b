#!/bin/bash

getBugDir () {
    dir="$(git root)"
    if [ -e "${dir}/.git/bugs" ]; then
        dir="${dir}/.git"
    fi
    echo "$dir"
}

if git root >/dev/null 2>&1 ; then
    bugDir=$(getBugDir)
    python ~/src/t/t.py --delete-if-empty --task-dir $bugDir --list bugs $@
else
    echo "(No repo here)"
fi

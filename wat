#!/usr/bin/env bash

msg=""

case ${0##*/} in
    "wtf")
        msg="I have no idea, man."
        ;;
    "lol")
        msg="  D:"
        ;;

    "wtd")
        msg="It is truly a mystery."
        ;;
    "oh")
        msg="Yes, it's all becoming clear now."
        ;;
    "ok")
        msg="yes"
        ;;
    "hm")
        msg="¯\(°_o)/¯"
        ;;
    "fuck")
        msg='
╭╮──────────────────╮
╰│                  │
 │       Get        │
 │       Rekt       │
 │                  │
 │       Lol        │
 │╮─────────────────┴╮
 ╰╯──────────────────╯'
        ;;
    *)
        msg="      wat"
esac

echo
(
IFS=$'\n'
read -r lin; echo "$lin"
while read -r lin; do
    echo "$lin"
    sleep 0.3
done;
) < <(echo "$msg")
echo

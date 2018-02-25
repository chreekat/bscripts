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
    *)
        msg="      wat"
esac

echo -e "\n$msg\n"

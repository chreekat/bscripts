#!/bin/bash

msg=""

case ${0##*/} in
    "wtf")
        msg="I have no idea, man."
        ;;
    "lol")
        msg="  D:"
        ;;
    *)
        msg="      wat"
esac

echo -e "\n$msg\n"

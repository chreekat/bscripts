#!/usr/bin/env bash
case `basename $0` in
    m)
        vim +set\ buftype=nofile +'0,$d' +'silent! 0pu +' +1
        ;;
    mm)
        vim +set\ buftype=nofile +'0,$d' +'silent! 0pu +' +1 +'setf mail'
        ;;
esac

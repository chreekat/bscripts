#!/bin/bash
if [ ${0##*/} = "mm" ]; then
    vim +set\ buftype=nofile +'0,$d' +'silent! 0pu +' +'normal gggwG'
else
    vim +set\ buftype=nofile +'0,$d' +'silent! 0pu +'
fi

#!/bin/bash
vim +set\ buftype=nofile +'0,$d' +'silent! 0pu +' +'normal gggwG'

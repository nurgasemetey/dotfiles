#!/bin/sh
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
dt=`date '+%d/%m/%Y %H:%M:%S'`
echo "$dt" | setclip
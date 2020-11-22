#!/bin/sh
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
printf "curl -X POST -H 'Content-type: application/json' --data '{\"text\":\"Finished\"}' $HOOK_URL | setclip

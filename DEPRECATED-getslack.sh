#!/bin/sh
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
printf "curl -X POST -H 'Content-type: application/json' --data '{\"text\":\"Finished\"}' https://hooks.slack.com/services/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" | setclip
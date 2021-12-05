#!/bin/sh
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
printf "db.products.insert( { item: \"card\", qty: 15 } )" | setclip
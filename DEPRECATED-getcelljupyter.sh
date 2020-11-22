#!/bin/sh
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
echo "# In[]" | setclip

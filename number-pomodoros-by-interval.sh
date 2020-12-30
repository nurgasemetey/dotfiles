#!/bin/bash
INTERVAL=$1
d=`date +%Y-%m-%d`
articlePath="/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/want-to-know/"
pomodoroCount=$(grep -o "$INTERVAL" "$articlePath$d.md" | wc -l)
echo $(( pomodoroCount*100/6 ))
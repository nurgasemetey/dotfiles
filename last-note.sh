#!/bin/bash
text=$(zenity --entry --title "Last note" --text "Enter text")
echo "$text"
file="/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/tmp-storage/last-note.txt"
if [ -z "$text" ]
then
    echo "Empty text"
else
	echo $text > $file
fi

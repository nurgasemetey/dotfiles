#!/bin/bash
text=$(zenity --entry --title "Laterbox" --text "Enter text")
echo "$text"
d=`date +%Y-%m-%d`
echo $d
articlePath="/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/want-to-know/"

if [ -z "$text" ]
then
      echo "Empty text"
else
	printf "* $text\n" >> "$articlePath$d.md"
fi

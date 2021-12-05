#!/bin/bash
link=$(zenity --entry --title "Article to batch" --text "Enter a link")
echo "$link"
d=`date +%d-%m-%Y`
echo $d
articlePath="/home/nurgasemetey/Desktop/articles/"
if [ -z "$link" ]
then
      echo "Empty link"
else
      printf "* $link\n" >> "$articlePath$d.md"
fi

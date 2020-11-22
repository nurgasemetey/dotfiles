#!/bin/bash
RETURNVALUE=`zenity --forms --title "Notify" --text  "---" --add-entry "Text" --add-entry="Minutes"`
text=$(awk -F'|' '{print $1}' <<<$RETURNVALUE);
minute=$(awk -F'|' '{print $2}' <<<$RETURNVALUE);
# echo $minute

echo "notify-send \"$text\" && paplay /home/nurgasemetey/Desktop/scripts/slow-spring-board.ogg"| at now + $minute minutes
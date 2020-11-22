#!/bin/bash
text=$(zenity --entry --title "Last intention" --text "Enter your intention")
echo "$text"
articlePath="/home/nurgasemetey/.cinnamon/configs/last-intention@nurgasemetey.org/73.json"
if [ -z "$text" ]
then
    echo "Empty text"
else
	jq --arg text "$text" '."custom-label".value = $text' $articlePath| sponge $articlePath
fi

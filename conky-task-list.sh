#!/bin/bash
MONTH_NAME=$(date +%B | tr '[:lower:]' '[:upper:]')
# echo $MONTH_NAME
MONTH=$(date +%m)
# echo $MONTH
DATE=$(date +'%Y-%m-%d')
articlePath="/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/want-to-know/$MONTH-$MONTH_NAME/$MONTH_NAME-TASKS.md"
# echo $articlePath
# echo $DATE
sed -ne '/'$DATE'/,$ p' $articlePath  | fold -w 20
echo SCREEN_UNLOCKED;
text=$(zenity --entry --title "Laterbox" --text "Enter your INTENTION")
echo "$text"
articlePath="/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/tmp-storage/intentions.txt"
if [ -z "$text" ]
then
        echo "Empty text"
else
    printf "$(date +"%H:%M") $text\n" >> "$articlePath"
fi
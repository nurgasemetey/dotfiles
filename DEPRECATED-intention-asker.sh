#!/bin/sh
# env DISPLAY=:1

screen_unlocked () {
	echo SCREEN_UNLOCKED;
	text=$(zenity --entry --title "Laterbox" --text "Enter your INTENTION")
	echo "$text"
	d=`date +%Y-%m-%d`
	echo $d
	articlePath="/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/want-to-know/"
	if [ -z "$text" ]
	then
	      echo "Empty text"
	else
		printf "* MY INTENTION is $text\n" >> "$articlePath$d.md"
	fi
}

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver'" |
  while read x; do
    case "$x" in
      *"boolean true"*) echo SCREEN_LOCKED;;
      *"boolean false"*) screen_unlocked;;
    esac
  done
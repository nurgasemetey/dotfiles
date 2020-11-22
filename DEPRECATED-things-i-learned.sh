#!/bin/bash
regex='([0-9][0-9])/([0-9][0-9])/([0-9][0-9])'
while read line; do
  if [[ $line =~ $regex ]] ; then echo $line; break; fi
done <'/home/nurgasemetey/Desktop/personal-organization/Evernote: Things I Learned.enmd'
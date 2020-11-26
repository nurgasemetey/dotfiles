#!/bin/bash
d=`date +%Y-%m-%d`
articlePath="/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/want-to-know/"
grep -iE '(2[0-4]|1[0-9]|[0-9])-(2[0-4]|1[0-9]|[0-9]):' "$articlePath$d.md" | tail -n1
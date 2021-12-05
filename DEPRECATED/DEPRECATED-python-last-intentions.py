#!/usr/bin/python3

import textwrap
file1 = open('/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/tmp-storage/intentions.txt', 'r') 
Lines = file1.readlines() 
for line in Lines: 
    print(textwrap.fill(line, width=20, subsequent_indent=' ' * 2))

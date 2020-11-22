#!/usr/bin/python2.7

import datetime
now = datetime.datetime.now()
time_intervals = [
	(0,3), (3,6), (6,9),(9,12),(12,15), (15,18), (18,21),(21,)
]

import subprocess

def copy2clip(txt):
    cmd='echo -n '+txt+'|xclip -selection c'
    return subprocess.check_call(cmd, shell=True)
for i in time_intervals:
	if i[0] == 21:
		copy2clip("21-24: ")
		break
	if i[0] <= now.hour and now.hour < i[1]:
		copy2clip("{}-{}: ".format(i[0], i[1]))
		break

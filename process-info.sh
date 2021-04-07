#!/bin/bash
# ps aux | grep staff
zenity --info --text=`ps aux | grep staff | grep -v grep| awk '{ print $8 }'`
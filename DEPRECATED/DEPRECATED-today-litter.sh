#!/bin/bash
month=`date +%m-%Y`
d=`date +%d-%m-%Y`
lidDirectory="/home/nurgasemetey/Desktop/lid-closes"
tail -n 10 "$lidDirectory/$month/$d.csv"
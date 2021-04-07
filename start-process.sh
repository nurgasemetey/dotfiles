#!/bin/bash
set -x
pid=$(pidof staffcounter)
echo $pid
kill -s CONT $pid
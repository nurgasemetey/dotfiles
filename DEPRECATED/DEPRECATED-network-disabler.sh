#!/bin/bash

# set -e
dbus-launch --exit-with-session nmcli dev disconnect iface wlp2s0
dbus-launch --exit-with-session nmcli dev disconnect iface enx007100ff27e8
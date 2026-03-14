#!/bin/bash

pkill firefox
#nohup firefox &
nohup firefox > /tmp/alexa.log 2>&1 &
sleep 2
xdotool search --onlyvisible --class "firefox" windowactivate key F11
firefox https://www.youtube.com/tv#/

#!/bin/bash

sudo -i -u sofi tmux has-session -t scream 2>/dev/null
if [ "$?" -eq 1 ] ; then
  sudo -i -u sofi PULSE_SERVER=/run/user/1000/pulse/native tmux new -d -s scream 'scream-pulse -u -p 4011 -i virbr0'
  echo "Scream started."
else
  echo "Scream already running."
fi
exit

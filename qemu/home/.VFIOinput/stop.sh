#!/bin/bash

sudo -i -u sofi tmux has-session -t scream 2>/dev/null
if [ "$?" -eq 1 ] ; then
  echo "Scream not running."
else
  sudo -i -u sofi tmux kill-session -t scream
  echo "Scream stopped."
fi
exit

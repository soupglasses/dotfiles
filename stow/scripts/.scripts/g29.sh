#!/bin/sh
# Logitech G29 as G27 Racing Wheel
# set range to desired lock to lock in degrees (900 max)
#range="360"
echo 'Please write the range you want in degrees: (360/500/900)'
read range
cd /sys/devices
echo Finding Steering wheel...
altmodes=`find -name alternate_modes`
echo FOUND!
cat $altmodes
echo Setting Alternative mode...
sudo bash -c "echo 'G27' > $altmodes"
sleep 7
echo Setting range...
altmodes=`find -name alternate_modes`
cat $altmodes
rfile=`find -name range | grep -i '046d:c29b'`
sudo bash -c "echo $range > $rfile"
echo Range has been set to $range degrees!
echo Script terminating...

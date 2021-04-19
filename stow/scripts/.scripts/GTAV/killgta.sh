#!/bin/sh
killall -9 -r ".*\.exe|.*SocialClub.*|.*Rockstar.*" & kill -9 $(ps aux | grep '.*PlayGTA.*' | awk '{print $2}')

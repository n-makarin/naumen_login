#!/bin/bash
realpath=/Users/nmakarin/prog/rc/naumen_login/

killall 'Google Chrome' &&

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 &

python3 "$realpath"src/login.py $realpath

exit 0


#!/bin/sh
PICTURES=/home/dayton/Pictures/backgrounds
SLIM_BACKGROUND=/usr/share/slim/themes/random/background.jpg

picture=$(find $PICTURES -type f -name '*.jpg' | shuf -n1)
ln -fs $picture $SLIM_BACKGROUND


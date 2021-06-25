#!/bin/bash

if ! [ -f "$1" ]
then
    echo "Please provide path to hex file as first argument"
    exit 1
fi

HEX_PATH=$( realpath $1 )

xhost +

docker run -it --rm \
    --privileged \
    -e DISPLAY=unix$DISPLAY \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HEX_PATH:$HEX_PATH \
    bbinet/mplabx /usr/bin/mplab_ipe

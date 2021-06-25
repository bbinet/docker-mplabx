#!/bin/bash

xhost +

docker run -it --rm \
    --privileged \
    -e DISPLAY=unix$DISPLAY \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:$HOME \
    bbinet/mplabx /usr/bin/mplab_ide

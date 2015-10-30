docker-mplabx
=============

[MPLABX](https://github.com/bbinet/mplabx): the MPLAB X Integrated Development
Environment docker container.


Build
-----

To create the image `bbinet/mplabx`, execute the following command in the
`docker-mplabx` folder:

    docker build -t bbinet/mplabx .

You can now push the new image to the public registry:
    
    docker push bbinet/mplabx


Run
---

Then, when starting your mplabx container, you will want to share the X11
socket file as a volume so that the MPLAB X windows can be displayed on you
Xorg server. You may also need to run command `xhost +` on the host.

    $ docker pull bbinet/mplabx

    $ docker run -it --name mplabx \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /path/to/mplab/projects:/path/to/mplab/projects \
        -e DISPLAY=unix$DISPLAY \
        bbinet/mplabx

In order to program PIC microcontrollers, the mplabx container need to connect
to the USB PIC programmer, so you may want to give it access to your USB
devices with:

    $ docker run -it --name mplabx \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /path/to/mplab/projects:/path/to/mplab/projects \
        -e DISPLAY=unix$DISPLAY \
        bbinet/mplabx

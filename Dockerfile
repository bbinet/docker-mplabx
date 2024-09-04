FROM debian:bookworm

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV DEBIAN_FRONTEND noninteractive

# Microchip tools require i386 compatability libs
RUN dpkg --add-architecture i386 \
    && apt-get update -yq \
    && apt-get install -yq --no-install-recommends curl libc6:i386 \
    libx11-6:i386 libxext6:i386 libstdc++6:i386 libexpat1:i386 \
    libxext6 libxrender1 libxtst6 libgtk2.0-0 libxslt1.1 procps \
    ca-certificates libusb-1.0-0

ENV XC16_VERSION 2.10

# Download and install XC16 compiler
RUN curl -fSL -A "Mozilla/4.0" -o /tmp/xc16.run "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/xc16-v${XC16_VERSION}-full-install-linux64-installer.run" \
    && chmod a+x /tmp/xc16.run \
    && /tmp/xc16.run --mode unattended --unattendedmodeui none \
        --netservername localhost --LicenseType FreeMode \
    && rm /tmp/xc16.run
ENV PATH /opt/microchip/xc16/v${XC16_VERSION}/bin:$PATH

ENV MPLABX_VERSION 6.20

# Download and install MPLAB X IDE
# Use url: http://www.microchip.com/mplabx-ide-linux-installer to get the latest version
RUN curl -qgb "" -fLC - --retry 3 --retry-delay 3 -e "https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide" -o /tmp/mplabx-installer.tar "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/MPLABX-v${MPLABX_VERSION}-linux-installer.tar" \
    && tar xf /tmp/mplabx-installer.tar && rm /tmp/mplabx-installer.tar \
    && USER=root ./MPLABX-v${MPLABX_VERSION}-linux-installer.sh --nox11 \
        -- --unattendedmodeui none --mode unattended \
    && rm ./MPLABX-v${MPLABX_VERSION}-linux-installer.sh

# Download and install Legacy PIC24 MCU & dsPIC DSC Peripheral Library
RUN curl -fSL -A "Mozilla/4.0" -o /tmp/plib.run "https://ww1.microchip.com/downloads/en//softwarelibrary/pic24%20mcu%20dspic%20peripheral%20lib/peripheral-libraries-for-pic24-and-dspic-v2.00-linux-installer.run" \
    && chmod a+x /tmp/plib.run \
    && /tmp/plib.run --mode unattended --unattendedmodeui none \
    && rm /tmp/plib.run

VOLUME ["/tmp/.X11-unix"]

CMD ["/usr/bin/mplab_ide"]

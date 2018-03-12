FROM debian:testing-slim as debian
LABEL maintainer="clee@mg8.org"

ENV KEYBOARD pearl
ENV KEYMAP default
ENV FLASHUTIL program

RUN apt-get update
RUN apt-get install -y build-essential python-pip git gcc-avr avr-libc libusb-dev
RUN pip install pyusb libusb

COPY ./bootloadHID /opt/bootloadHID/
WORKDIR /opt/bootloadHID/commandline
RUN make 
RUN install ./bootloadHID /bin

COPY ./qmk_firmware /opt/qmk_firmware/
WORKDIR /opt/qmk_firmware

CMD ["/bin/sh", "-c", "make $KEYBOARD:$KEYMAP $KEYBOARD:$KEYMAP:$FLASHUTIL" ]
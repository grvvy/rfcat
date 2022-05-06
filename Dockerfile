# Sandbox test environment for RFCat
FROM ubuntu:20.04
CMD ["/bin/bash"]

# Override interactive installations and install prerequisites
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get install -y \
    libusb-1.0-0 \
    make \
    python2 \
    python3 \
    python-is-python3 \
    python-usb \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'deb http://ftp.debian.org/debian stretch main' >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
    04EE7237B7D453EC 648ACFD622F3D138 0E98404D386FA1D9 EF0F382A1A7B6500
RUN apt-get update && apt-get install -y -t stretch sdcc=3.5.0+dfsg-2+b1
RUN pip install future
RUN pip3 install git+https://github.com/CapableRobot/CapableRobot_USBHub_Driver --upgrade

RUN sysctl kernel.dmesg_restrict=0

# Inform Docker that the container is listening on port 8080 at runtime
EXPOSE 8080

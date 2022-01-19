# Use the official image as a parent image
FROM ubuntu:20.04

# Add Jenkins as a user with sufficient permissions
RUN mkdir /home/jenkins
RUN groupadd -g 136 jenkins
RUN useradd -r -u 126 -g jenkins -G plugdev -d /home/jenkins jenkins
RUN chown jenkins:jenkins /home/jenkins

WORKDIR /home/jenkins

CMD ["/bin/bash"]

# override interactive installations
ENV DEBIAN_FRONTEND=noninteractive 

# Install prerequisites
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
RUN pip3 install capablerobot_usbhub

USER jenkins

# Inform Docker that the container is listening on the specified port at runtime.
EXPOSE 8080

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .
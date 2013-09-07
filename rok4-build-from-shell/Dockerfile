# Dockerfile for building a simple rok4 server on ubuntu
FROM ubuntu
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# Which ROK4 version and md5sum for the sourcecode ?
ENV ROK4VERSION 0.14.0
ENV PLATFORM_SPECIFIC_ROK4_BUILD_SCRIPT rok4-ubuntu-build.sh

# First of all, we need to get a safe upgrade of apt repositories to start with a clean worker
RUN apt-get update
RUN apt-get upgrade -y

# Install deps
RUN apt-get install -y build-essential
RUN apt-get install -y curl
RUN apt-get install -y gettext nasm automake cmake

# Copy needed build script while we are in source only
ADD $PLATFORM_SPECIFIC_ROK4_BUILD_SCRIPT /tmp/build.sh
RUN chmod +x /tmp/build.sh
RUN /tmp/build.sh $ROK4VERSION

RUN apt-get autoremove -y --purge build-essential gettext nasm automake cmake curl
RUN rm -rf /tmp/*
RUN echo date > /root/last-apt-get-update.txt


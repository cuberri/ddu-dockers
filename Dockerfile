# Dockerfile for building a simple rok4 server on ubuntu
FROM ubuntu
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# Which ROK4 version and md5sum for the sourcecode ?
ENV ROK4VERSION 0.14.0
ENV ROK4BUILDIR /tmp/rok4-src/build
# First of all, we need to get a safe upgrade of apt repositories to start with a clean worker
RUN apt-get install -y aptitude
RUN aptitude update
RUN aptitude safe-upgrade -y

# Then, we need to install all needed dependencies for building ROK4 only (cf. http://www.rok4.org/documentation/rok4-installation)
RUN aptitude install -y build-essential gettext nasm automake cmake 

# Preapring the source build
RUN curl -o /tmp/rok4-${ROK4VERSION}.tar.bz2 "http://www.rok4.org/data/rok4-${ROK4VERSION}.tar.bz2"
RUN cd /tmp/;tar xjf rok4-${ROK4VERSION}.tar.bz2
RUN mv /tmp/$(basename $(cd /tmp/;find . -maxdepth 1 -type d -name "rok4*")) $(basename ${ROK4BUILDIR})
RUN mkdir -p ${ROK4BUILDIR}
RUN cd ${ROK4BUILDIR};cmake .. -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/local/rok4 -DCMAKE_BUILD_TYPE=Release -DBUILD_ROK4=TRUE -DBUILD_BE4=FALSE -DBUILD_DOC=FALSE -DUNITTEST=FALSE -DDEBUG_BUILD=FALSE  
RUN cd make -j$(grep ^processor /proc/cpuinfo  | wc -l)
#RUN make -j8
RUN make install

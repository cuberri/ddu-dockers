# Dockerfile for building a simple rok4 server on ubuntu
FROM ubuntu
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# Which ROK4 version and md5sum for the sourcecode ?
ENV ROK4_VERSION 0.14.0
ENV ROK4_SRC_URL http://www.rok4.org/data/rok4-${ROK4_VERSION}.tar.bz2

# First of all, we need to get a safe upgrade of apt repositories to start with a clean worker
RUN apt-get update
RUN apt-get upgrade -y

# Install deps
RUN apt-get install -y build-essential
RUN apt-get install -y curl
RUN apt-get install -y gettext nasm automake cmake

# Copy needed build script while we are in source only
RUN cd /tmp;curl ${ROK4_SRC_URL} | tar xjf -
RUN mv /tmp/$(basename $(cd /tmp/;find . -maxdepth 1 -type d -name "rok4*")) /tmp/rok4
RUN mkdir -p /tmp/rok4/build
RUN cd /tmp/rok4/build;cmake .. -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/local/rok4 -DCMAKE_BUILD_TYPE=Release -DBUILD_ROK4=TRUE -DBUILD_BE4=FALSE -DBUILD_DOC=FALSE -DUNITTEST=FALSE -DDEBUG_BUILD=FALSE
RUN cd /tmp/rok4/build;make
RUN cd /tmp/rok4/build;make install

# Cleaning build dir
RUN apt-get autoremove -y --purge build-essential gettext nasm automake cmake curl
RUN rm -rf /tmp/*

# Configuring ROK4
# First we use build's sample configurations
RUN cp /usr/local/rok4/config/server.conf.sample /usr/local/rok4/config/server.conf
RUN cp /usr/local/rok4/config/services.conf.sample /usr/local/rok4/config/services.conf
# Then, we configure some directives for our build
RUN sed -i 's#<logFilePrefix>/var/tmp/rok4</logFilePrefix>#<logFilePrefix>/var/log/rok4</logFilePrefix>#g' /usr/local/rok4/config/server.conf # log dir more "standard"
RUN sed -i 's#<serverPort></serverPort>#<serverPort>127.0.0.1:9000</serverPort>#g' /usr/local/rok4/config/server.conf # Standalone mode
RUN sed -i 's#../config#/usr/local/rok4/config#g' /usr/local/rok4/config/server.conf

# Running ROK4
EXPOSE 9000

CMD ["/usr/local/rok4/bin/rok4", "-f", "/usr/local/rok4/config/server.conf"]


# Dockerfile for mounting an apt-cacher instance
FROM ubuntu
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# Adding universe repositories to get apt-cacher
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ raring universe" >> /etc/apt/sources.list; echo "deb-src http://us.archive.ubuntu.com/ubuntu/ raring universe" >> /etc/apt/sources.list; echo "deb http://us.archive.ubuntu.com/ubuntu/ raring-updates universe" >> /etc/apt/sources.list; echo "deb-src http://us.archive.ubuntu.com/ubuntu/ raring-updates universe"

# Need to be up-to-date
RUN apt-get update && apt-get upgrade -y

# Install apt-cacher (cf. http://doc.ubuntu-fr.org/apt-cacher) and some others needed tools
RUN apt-get install -y apt-cacher apache2 python-setuptools

# A little bit of configuration
RUN sed -i 's/#allowed_hosts/allowed_hosts/g' /etc/apt-cacher/apt-cacher.conf
RUN echo "Acquire::http::Proxy \"http://127.0.0.1:3142\";" >> /etc/apt/apt.conf.d/01proxy

# SupervisorD for launching apt-cacher
RUN easy_install supervisor
ADD supervisord.conf /etc/supervisord.conf

# And so final conf
EXPOSE 3142

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]

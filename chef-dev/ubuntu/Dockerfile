# Dockerfile for my vagrant/ruby/veewee/chef dev box
FROM ubuntu
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# APT caching
RUN echo "Acquire::http::Proxy \"http://88.190.56.116:3142\";" >> /etc/apt/apt.conf.d/01proxy

# Adding universe repositories to get apt-cacher
#RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ raring universe" >> /etc/apt/sources.list; echo "deb-src http://us.archive.ubuntu.com/ubuntu/ raring universe" >> /etc/apt/sources.list; echo "deb http://us.archive.ubuntu.com/ubuntu/ raring-updates universe" >> /etc/apt/sources.list; echo "deb-src http://us.archive.ubuntu.com/ubuntu/ raring-updates universe"

# Need to be up-to-date
RUN apt-get update && apt-get upgrade -y

# Install prequisites tools
RUN apt-get install -y build-essential curl vim git libxslt1-dev libxml2-dev zlib1g-dev lsb-release wget ruby1.9.1 ruby1.9.1-dev

# Install RVM from bash online installer
#RUN curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3

# Install Chef from omnigus installer
RUN curl -L https://www.opscode.com/chef/install.sh | bash

# Create base project structure
RUN mkdir -p /chef
ADD Gemfile /chef/
WORKDIR /chef
RUN gem install bundler
RUN bundle install

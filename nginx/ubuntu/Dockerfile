# Dockerfile for building a simple rok4 server on ubuntu
FROM ubuntu
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# Need to be up-to-date
RUN apt-get update
RUN apt-get upgrade -y

# Install official nginx repository
RUN apt-get install -y curl
RUN curl -o /tmp/nginx_signing.key "http://nginx.org/keys/nginx_signing.key"
RUN apt-key add /tmp/nginx_signing.key
RUN echo "deb http://nginx.org/packages/ubuntu/ $(grep CODENAME /etc/lsb-release | cut -d'=' -f2) nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ $(grep CODENAME /etc/lsb-release | cut -d'=' -f2) nginx" >> /etc/apt/sources.list 
RUN apt-get update

# Install official and basic nginx itself
RUN apt-get install -y nginx

# Configuring nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# cleaning
RUN apt-get autoremove -y --purge curl

# Running Nginx HTTP/HTTPS
EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]


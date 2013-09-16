# Dockerfile for building a simple rok4 server on ubuntu
FROM dduportal/simple-rok4-ubuntu
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# Install official nginx repository
RUN apt-get install -y curl python-setuptools
RUN curl -o /tmp/nginx_signing.key "http://nginx.org/keys/nginx_signing.key"
RUN apt-key add /tmp/nginx_signing.key
RUN echo "deb http://nginx.org/packages/ubuntu/ $(grep CODENAME /etc/lsb-release | cut -d'=' -f2) nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ $(grep CODENAME /etc/lsb-release | cut -d'=' -f2) nginx" >> /etc/apt/sources.list 
RUN apt-get update

# Install official and basic nginx itself
RUN apt-get install -y nginx

# Configuring nginx
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN sed -i 's#nginx;#root;#g' /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d/*.conf
ADD nginx-vhost-for-rok4.conf /etc/nginx/conf.d/rok4.conf

# Configuring ROK4 for listeing from socket
RUN sed -i 's#<serverPort>127.0.0.1:9000</serverPort>#<serverPort>/var/run/rok4sock</serverPort>#g' /usr/local/rok4/config/server.conf

# Adding some init script for starting rok4 and nginx together. You can use supervisord or your own solution. Here we want it lightweight
ADD rok4-init-script.sh /etc/init.d/rok4

# Now, install and configure supervisord for launching nginx and rok4 together
RUN easy_install supervisor
ADD supervisord.conf /etc/supervisord.conf

# cleaning
RUN apt-get autoremove -y --purge curl

# Running Nginx HTTP
EXPOSE 80

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]

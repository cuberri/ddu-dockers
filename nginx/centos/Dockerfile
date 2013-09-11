# Dockerfile for building a simple rok4 server on ubuntu
FROM centos
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

# Install official nginx repository
RUN echo -e "[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/nginx.repo
RUN yum update -y

# Install official and basic nginx itself
RUN yum install -y nginx

# Configuring nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf


# Running Nginx HTTP/HTTPS
EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]


#!/bin/bash

# Simple init script for nginx and rok4 together
# All is written as-it to be as simple as possible
# Damien DUPORTAL <damien.duportal@gmail.com>
#

LANG=C /usr/local/rok4/bin/rok4 -f /usr/local/rok4/config/server.conf &
/usr/sbin/nginx -c /etc/nginx/nginx.conf &


#!/bin/sh
apt-get update
apt-get upgrade -y
apt-get autoremove
# nfs / automount
apt-get install -y nfs-kernel-server autofs5 avahi-daemon 
# mdns 
apt-get install -y avahi-daemon 
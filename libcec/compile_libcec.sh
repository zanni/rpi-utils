#!/bin/bash
# install cec-client on RPI Raspian wheezy

# install dependencies
sudo apt-get -y install git-core autoconf automake libtool liblockdev1-dev
cd /usr/local/src

git clone https://github.com/Pulse-Eight/libcec.git
cd libcec

autoreconf -vif
./configure --enable-rpi
# patch libcec for rpi
wget -O libCEC.patch "https://sites.google.com/a/roberteklund.org/www/projects/raspberry-pi/libCEC.patch?attredirects=0&d=1"
patch -p1 < libCEC.patch

make
sudo su
make install-strip
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig

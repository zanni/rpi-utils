#!/bin/sh
apt-get install -y libplist1 libmicrohttpd10 libtinyxml2.6.2 libyajl2 libssh-4 libmysqlclient18 liblzo2-2 libfribidi0 libcurl3-gnutls liblockdev1 libpcrecpp0
apt-get install -y liblockdev1
wget http://sourceforge.net/projects/selfprogramming/files/libCEC.deb/libcec_2.0.5-1_armhf.deb/download
mv download libcec.deb
dpkg -i libcec.deb

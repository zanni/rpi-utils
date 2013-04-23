#!/bin/sh

cd /usr/lib

amixer cset numid=3 1
apt-get install -y git
sudo apt-get install -y build-essential libssl-dev libcrypt-openssl-rsa-perl libao-dev libio-socket-inet6-perl libwww-perl avahi-utils pkg-config 
aptitude install -y libmodule-build-perl
git clone https://github.com/njh/perl-net-sdp.git perl-net-sdp
cd perl-net-sdp
perl Build.PL
./Build
./Build test
./Build install
cd ..
git clone https://github.com/albertz/shairport.git
cd shairport
make install
cp shairport.init.sample /etc/init.d/shairport
ln -s /usr/local/bin/shairport.pl ./shairport.pl
insserv shairport
service avahi-daemon start 
service shairport start




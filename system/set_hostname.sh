#!/bin/bash
FS_PATH=/media/fs
if [[ -z "$1" ]]
then 
	echo "you must provide hostname"
	exit 1
else
	echo "/**********************************"/
	echo "	set device hostname: "$1
	echo $1 > $FS_PATH/etc/hostname
	echo "	create file:: "$FS_PATH/etc/hosts
	cat > $FS_PATH/etc/hosts <<-EOF
		127.0.0.1       localhost
		::1             localhost ip6-localhost ip6-loopback
		fe00::0         ip6-localnet
		ff00::0         ip6-mcastprefix
		ff02::1         ip6-allnodes
		ff02::2         ip6-allrouters

		127.0.1.1       $1
	EOF
fi






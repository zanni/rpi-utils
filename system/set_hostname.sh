#!/bin/bash
FS_PATH=/media/fs
if [[ -z "$1" ]]
then 
	echo "you must provide hostname"
	exit 1
else
	echo "set device hostname: "$1
	echo $1 > $FS_PATH/etc/hostname
fi

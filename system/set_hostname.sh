#!/bin/bash
if [[ -z "$1" ]]
then 
	echo "you must provide hostname"
	exit 1
else
	echo "set device hostname: "$1
	echo $1 > /media/fs/etc/hostname
fi

#!/bin/bash
MOUNT_PATH=$1
FILE_PATH=../build/distrib
FILE_NAME=current.img

PISCES_URL=http://archive.raspbian.org/images/rpi_pisces_r3.zip
PISCES_FILE_NAME=rpi_pisces_r3

if [[ -z "$1" ]]
then 
	echo "you must provide mount path"
	exit 1
else
	echo "do you really want to erase:"$1" (y/n) ?"
	read line
	if [ ! "$line" = "y" ]
	then
		echo "quit"
		exit 0
	fi
fi
if [ ! -d $FILE_PATH  ]
then
	mkdir $FILE_PATH
fi

if [ ! -f $FILE_PATH/$FILE_NAME ]
then
	cd $FILE_PATH
    if [ ! -f $FILE_PATH/$PISCES_FILE_NAME.img  ]
	then
		echo "download: "$PISCES_FILE_NAME.img
		wget $PISCES_URL
		unzip $PISCES_FILE_NAME.zip
		rm $PISCES_FILE_NAME.zip
		ln -s $PISCES_FILE_NAME.img $FILE_NAME
	fi	
	cd ..
fi
dd bs=4M if=$FILE_PATH/$FILE_NAME of=$MOUNT_PATH
sync

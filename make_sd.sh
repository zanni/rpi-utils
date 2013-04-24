#!/bin/bash
MOUNT_PATH=$1
FILE_PATH=system
FILE_NAME=current.img

RASPBIAN_URL=http://files.velocix.com/c1410/images/raspbian/2013-02-09-wheezy-raspbian/2013-02-09-wheezy-raspbian.zip
RASPBIAN_FILE_NAME=2013-02-09-wheezy-raspbian

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
    if [ ! -f $FILE_PATH/$RASPBIAN_FILE_NAME.img  ]
	then
		echo "download: "$RASPBIAN_FILE_NAME.img
		wget $RASPBIAN_URL
		unzip $RASPBIAN_FILE_NAME.zip
		rm $RASPBIAN_FILE_NAME.zip
		ln -s $RASPBIAN_FILE_NAME.img $FILE_NAME
	fi	
	cd ..
fi
dd bs=4M if=$FILE_PATH/$FILE_NAME of=$MOUNT_PATH
sync

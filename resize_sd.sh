#!/bin/bash
MOUNT_PATH=$1
P1=1
P2=2
DISK=`sudo parted $MOUNT_PATH unit chs print | grep Disk`
var=$(echo $DISK | awk -F" " '{print $1,$2,$3}')   
set -- $var
END=$3

START=`sudo parted $MOUNT_PATH unit chs print | grep fat16`
var=$(echo $START | awk -F"\t" '{print $1,$2,$3}')   
set -- $var
START=$3

#sudo parted $MOUNT_PATH unit chs
#sudo parted $MOUNT_PATH rm 2

echo $START 
echo $END
sudo parted $MOUNT_PATH unit chs print rm 2 mkpart primary $START $END
sudo e2fsck -f  $MOUNT_PATH$P2
sudo resize2fs $MOUNT_PATH$P2

#!/bin/bash
MOUNT_PATH=$1
FS_PATH=/media/fs
BOOT_PATH=/media/boot
P1=1
P2=2
if [ ! -d $FS_PATH  ]
then
	mkdir -p $FS_PATH
fi
if [ ! -d $BOOT_PATH  ]
then
	mkdir -p $BOOT_PATH
fi
# umount $MOUNT_PATH$P1
# umount $MOUNT_PATH$P2
mount $MOUNT_PATH$P1 $BOOT_PATH
mount $MOUNT_PATH$P2 $FS_PATH


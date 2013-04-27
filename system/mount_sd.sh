#!/bin/bash
MOUNT_PATH=$1
FS_PATH=/media/fs
BOOT_PATH=/media/boot
P1=1
P2=2
umount $MOUNT_PATH$P1
umount $MOUNT_PATH$P2
mount $MOUNT_PATH$P1 $BOOT_PATH
mount $MOUNT_PATH$P2 $FS_PATH


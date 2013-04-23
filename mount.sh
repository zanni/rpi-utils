#!/bin/bash
MOUNT_PATH=$1
P1=1
P2=2
umount $MOUNT_PATH$P1
umount $MOUNT_PATH$P2
mount $MOUNT_PATH$P1 /media/boot
mount $MOUNT_PATH$P2 /media/fs


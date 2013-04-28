#!/bin/bash

DEF_BOOT=/media/boot
DEF_FS=/media/fs
P1=1
P2=2
if [[ -z "$1" ]]; then
	BOOT=$DEF_BOOT
	FS=$DEF_FS
else
	BOOT=$1$P1
	FS=$1$P2
fi
sync
umount $BOOT
umount $FS

rm -rf $DEF_BOOT
rm -rf $DEF_FS
#!/bin/bash
MOUNT_PATH=$1
dd bs=4M if=system/2012-12-16-wheezy-raspbian.img of=$MOUNT_PATH
sync

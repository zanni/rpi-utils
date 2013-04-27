#!/bin/bash
MOUNT_PATH=$1
NAME=$2
FILE_PATH=../build/distrib

dd bs=4M if=$MOUNT_PATH of=$FILE_PATH/$NAME.img

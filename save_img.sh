#!/bin/bash
MOUNT_PATH=$1
dd bs=4M if=$MOUNT_PATH of=saved.img

#!/bin/bash
rm -R /media/fs/lib/firmware
rm -R /media/fs/lib/modules
cp -R ../modules/lib/firmware /media/fs/lib/
cp -R ../modules/lib/modules /media/fs/lib/

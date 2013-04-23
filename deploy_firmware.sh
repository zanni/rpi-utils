#!/bin/bash
rm /media/boot/bootcode.bin
rm /media/boot/fixup.dat
rm /media/boot/start.elf
cp ../firmware/boot/bootcode.bin /media/boot/
cp ../firmware/boot/fixup.dat /media/boot/
cp ../firmware/boot/start.elf /media/boot/

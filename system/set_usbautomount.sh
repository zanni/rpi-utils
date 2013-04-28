#!/bin/bash
FS_PATH=/media/fs
echo "/**********************************"/
echo "Setup usb automount..."
echo "	create file: "$FS_PATH/etc/udev/rules.d/10-usbautomount.rule
cat > $FS_PATH/etc/udev/rules.d/10-usbautomount.rule <<-EOF
	KERNEL!="sd[a-z]*", GOTO="auto_mount_end"
	ACTION=="add", PROGRAM!="/sbin/blkid %N", GOTO="auto_mount_end"

	# Set environment
	ACTION=="add", IMPORT{program}="/sbin/blkid -o udev -p -s TYPE -s LABEL %N"

	# Global mount options
	ACTION=="add", ENV{mount_options}="relatime,users"

	# Filesystem specific options
	ACTION=="add", ENV{ID_FS_TYPE}=="vfat", ENV{mount_options}="%E{mount_options},showexec"
	ACTION=="add", ENV{ID_FS_TYPE}=="ntfs", ENV{mount_options}="%E{mount_options},utf8"

	# Get mount point
	# use basename to correctly handle labels such as ../mnt/foo
	ACTION=="add", ENV{ID_FS_LABEL}=="?*", PROGRAM="/usr/bin/basename '%E{ID_FS_LABEL}'", ENV{dir_name}="%c"
	ACTION=="add", ENV{dir_name}!="?*", ENV{dir_name}="usbhd-%k"

	# Main action
	ACTION=="add", ENV{dir_name}=="?*", RUN+="/bin/mkdir -p '/media/%E{dir_name}'", RUN+="/bin/mount -o %E{mount_options} /dev/%k '/media/%E{dir_name}'"
	ACTION=="remove", ENV{dir_name}=="?*", RUN+="/bin/umount -l '/media/%E{dir_name}'", RUN+="/bin/rmdir '/media/%E{dir_name}'"

	LABEL="auto_mount_end"

	# label must be cleared
	ENV{ID_FS_LABEL}=""
EOF
 
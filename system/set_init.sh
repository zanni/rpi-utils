#!/bin/bash
FS_PATH=/media/fs
CONNECT_PATH=/etc/connect
CONNECT_INITD_NAME=connect_init
CONNECT_SRC_NAME=init.sh
INITD_PATH=/etc/init.d
RCSD_PATH=/etc/rcS.d
echo "/**********************************"/
echo "Setup initialization scripts..."
mkdir -p $FS_PATH$CONNECT_PATH

echo "	create file: "$FS_PATH$CONNECT_PATH/$CONNECT_SRC_NAME
cat > $FS_PATH$CONNECT_PATH/$CONNECT_SRC_NAME <<-EOF
	#!/bin/sh
	# enable ssh
	update-rc.d ssh enable 
    invoke-rc.d ssh start 
    update-rc.d nfs-common defaults
    # mdns deps
	apt-get install -y avahi-daemon
    # update system
	apt-get update
	apt-get upgrade -y
	apt-get autoremove -y
	# nfs / automount deps
	apt-get install -y nfs-kernel-server autofs5
	mv /etc/exports.next /etc/exports
	 
EOF
echo "	create file: "$FS_PATH$INITD_PATH/$CONNECT_INITD_NAME 
echo '
	#/etc/init.d/yourscript:
	#!/bin/bash
	#
	# yourscript  short description
	# 
	# chkconfig: 2345 9 20
	# description: long description
	CONNECT_PATH=/etc/connect
	LOG=/var/connect.log
	case "$1" in
	  start)
		cd $CONNECT_PATH
		for x in `ls *.sh`
		do
			sudo chmod +x $CONNECT_PATH/$x
			sudo sh -c "$CONNECT_PATH/$x  &> $LOG"

			mv $CONNECT_PATH/$x $CONNECT_PATH/$x.done
		done
	  ;;
	  stop|status|restart|reload|force-reload)
	    # do nothing
	  ;;
	esac
' > $FS_PATH$INITD_PATH/$CONNECT_INITD_NAME 

chmod +x $FS_PATH$INITD_PATH/$CONNECT_INITD_NAME 
cd $FS_PATH$RCSD_PATH
rm $CONNECT_INITD_NAME
ln -s ../init.d/$CONNECT_INITD_NAME $CONNECT_INITD_NAME
echo "	create file: "$(pwd)$CONNECT_INITD_NAME
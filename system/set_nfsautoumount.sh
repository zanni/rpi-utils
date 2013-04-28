#!/bin/bash
FS_PATH=/media/fs
MOUNT_PATH=/mnt
echo "/**********************************"/
echo "Setup nfs automount..."

df | grep ".local" | cut  -f1 | cut -s -d' ' -f3 | 
while read host
do  # What you want
    
	echo $host
done
# authorize all computer on local network
#echo "	create file: "$FS_PATH/etc/hosts.allow 
#cat > $FS_PATH/etc/hosts.allow <<-EOF
# /etc/hosts.allow: list of hosts that are allowed to access the system.
#                   See the manual pages hosts_access(5) and hosts_options(5).
#
# Example:    ALL: LOCAL @some_netgroup
#             ALL: .foobar.edu EXCEPT terminalserver.foobar.edu
#
# If you're going to protect the portmapper use the name "portmap" for the
# daemon name. Remember that you can only use the keyword "ALL" and IP
# addresses (NOT host or domain names) for the portmapper, as well as for
# rpc.mountd (the NFS mount daemon). See portmap(8) and rpc.mountd(8)
# for further information.
#
# authorize all computer on local network
#ALL: *.local
#EOF
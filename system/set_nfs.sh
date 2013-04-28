#!/bin/bash
FS_PATH=/media/fs
echo "/**********************************"/
echo "Setup nfs..."
# authorize all computer on local network
echo "	create file: "$FS_PATH/etc/hosts.allow 
cat > $FS_PATH/etc/hosts.allow <<-EOF
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
ALL: *.local
EOF
# share /media folder 
echo "	create file: "$FS_PATH/etc/exports.next
cat > $FS_PATH/etc/exports.next <<-EOF
# /etc/exports: the access control list for filesystems which may be exported
#		to NFS clients.  See exports(5).
#
# Example for NFSv2 and NFSv3:
# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
#
# Example for NFSv4:
# /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
# /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
#
# share /media folder 
/media		   *.local(rw,sync,no_subtree_check)
EOF

 